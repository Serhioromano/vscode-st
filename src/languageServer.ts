'use strict';

import * as cp from 'child_process';
import * as fs from 'fs';
import * as https from 'https';
import * as os from 'os';
import * as path from 'path';
import { URL } from 'url';
import * as vscode from 'vscode';
import {
    ClientCapabilities,
    FeatureState,
    LanguageClient,
    LanguageClientOptions,
    ServerCapabilities,
    ServerOptions,
    StaticFeature,
} from 'vscode-languageclient/node';

import { STFormatterProvider } from './formatter';
import { STDocumentSymbolProvider } from './symbolprovider';
import { assetFileName, assetForPlatform, binaryName, releaseApiPath, StLspAsset } from './stLspRelease';

const repository = 'kropochev/st-lsp';
const sourcePattern = '**/*.{st,ST,scl,SCL,exp,EXP,vpl,VPL,iecplc,IECPLC,iecst,IECST,iecstl,IECSTL}';
const twinCatPattern = '**/*.{TcDUT,TcPOU,TcGVL,tcdut,tcpou,tcgvl}';

let generation = 0;
let client: LanguageClient | undefined;
let output: vscode.OutputChannel | undefined;
let fileWatcher: vscode.FileSystemWatcher | undefined;
const builtin: vscode.Disposable[] = [];

class KeepEditorProviders implements StaticFeature {
    public constructor(private readonly useLspFormatting: boolean) {
    }

    public fillClientCapabilities(_capabilities: ClientCapabilities): void {
    }

    public preInitialize(capabilities: ServerCapabilities): void {
        // The extension outline understands nested POUs. The server symbols are a flat list.
        capabilities.documentSymbolProvider = undefined;
        if (!this.useLspFormatting) {
            capabilities.documentFormattingProvider = undefined;
        }
    }

    public initialize(): void {
    }

    public getState(): FeatureState {
        return { kind: 'static' };
    }

    public dispose(): void {
    }
}

export async function startLanguageServer(context: vscode.ExtensionContext): Promise<void> {
    const token = ++generation;
    await stopClient();
    if (token !== generation) {
        return;
    }

    const config = vscode.workspace.getConfiguration('st');
    const enabled = config.get<boolean>('languageServer.enable', true);
    const useLspFormatting = enabled && config.get<boolean>('languageServer.formatting', false);
    registerBuiltin(useLspFormatting);
    if (!enabled) {
        log(context, 'Language server is disabled (st.languageServer.enable).');
        return;
    }

    try {
        const command = await resolveServerCommand(context, config);
        if (token !== generation) {
            return;
        }
        log(context, `Starting ${command}`);
        disposeWatcher();
        fileWatcher = vscode.workspace.createFileSystemWatcher(sourcePattern);
        const serverOptions: ServerOptions = { command, args: [] };
        const clientOptions: LanguageClientOptions = {
            documentSelector: [
                { scheme: 'file', language: 'st', pattern: sourcePattern },
                { scheme: 'untitled', language: 'st' },
            ],
            synchronize: {
                fileEvents: fileWatcher,
            },
            outputChannel: channel(context),
            initializationFailedHandler: (error) => {
                log(context, `Initialization failed: ${String(error)}`);
                return false;
            },
        };
        const next = new LanguageClient(
            'st.languageServer',
            'Structured Text',
            serverOptions,
            clientOptions,
        );
        next.registerFeature(new KeepEditorProviders(useLspFormatting));
        client = next;
        await next.start();
        if (token !== generation) {
            await next.stop().catch(() => undefined);
        }
    } catch (error) {
        if (token !== generation) {
            return;
        }
        const failed = client;
        client = undefined;
        if (failed) {
            await failed.stop().catch(() => undefined);
        }
        if (token !== generation) {
            return;
        }
        disposeWatcher();
        registerBuiltin(false);
        const message = error instanceof Error ? error.message : String(error);
        log(context, message);
        void vscode.window.showWarningMessage(`Structured Text language server is unavailable: ${message}`);
    }
}

export async function stopLanguageServer(): Promise<void> {
    generation++;
    disposeBuiltin();
    await stopClient();
}

function registerBuiltin(useLspFormatting: boolean): void {
    disposeBuiltin();
    builtin.push(vscode.languages.registerDocumentSymbolProvider(
        { language: 'st' },
        new STDocumentSymbolProvider(),
    ));
    const selector: vscode.DocumentSelector = useLspFormatting
        ? { language: 'st', pattern: twinCatPattern }
        : 'st';
    builtin.push(vscode.languages.registerDocumentFormattingEditProvider(
        selector,
        new STFormatterProvider(),
    ));
}

function disposeBuiltin(): void {
    while (builtin.length > 0) {
        builtin.pop()?.dispose();
    }
}

async function stopClient(): Promise<void> {
    disposeWatcher();
    const current = client;
    client = undefined;
    if (current) {
        await current.stop();
    }
}

function disposeWatcher(): void {
    fileWatcher?.dispose();
    fileWatcher = undefined;
}

function channel(context: vscode.ExtensionContext): vscode.OutputChannel {
    if (!output) {
        output = vscode.window.createOutputChannel('Structured Text Language Server');
        context.subscriptions.push(output);
    }
    return output;
}

function log(context: vscode.ExtensionContext, line: string): void {
    channel(context).appendLine(line);
}

async function resolveServerCommand(
    context: vscode.ExtensionContext,
    config: vscode.WorkspaceConfiguration,
): Promise<string> {
    const configured = config.get<string>('languageServer.path', '').trim();
    if (configured) {
        return existingFile(expandHome(configured), 'st.languageServer.path');
    }

    const fromEnv = (process.env.ST_LSP ?? process.env.ST_LSP_PATH ?? '').trim();
    if (fromEnv) {
        return existingFile(expandHome(fromEnv), 'ST_LSP');
    }

    if (context.extensionMode === vscode.ExtensionMode.Development) {
        const sibling = siblingBinary(context.extensionPath);
        if (sibling) {
            log(context, `Using sibling build ${sibling}`);
            return sibling;
        }
    }

    const onPath = findOnPath(binaryName(process.platform));
    if (onPath) {
        log(context, `Using ${onPath} from PATH`);
        return onPath;
    }

    return downloadServer(context, config.get<string>('languageServer.version', 'latest'));
}

function existingFile(filePath: string, label: string): string {
    if (!fs.existsSync(filePath) || !fs.statSync(filePath).isFile()) {
        throw new Error(`${label} does not exist: ${filePath}`);
    }
    return filePath;
}

function expandHome(input: string): string {
    if (input === '~') {
        return os.homedir();
    }
    if (input.startsWith('~/') || input.startsWith('~\\')) {
        return path.join(os.homedir(), input.slice(2));
    }
    return input;
}

function siblingBinary(extensionPath: string): string | undefined {
    const name = binaryName(process.platform);
    const base = path.resolve(extensionPath, '..', 'st-lsp', 'target');
    for (const profile of ['debug', 'release']) {
        const candidate = path.join(base, profile, name);
        if (fs.existsSync(candidate) && fs.statSync(candidate).isFile()) {
            return candidate;
        }
    }
    return undefined;
}

function findOnPath(fileName: string): string | undefined {
    const pathEnv = process.env.PATH ?? process.env.Path ?? '';
    const names = process.platform === 'win32' && !fileName.toLowerCase().endsWith('.exe')
        ? [`${fileName}.exe`, fileName]
        : [fileName];
    for (const dir of pathEnv.split(path.delimiter)) {
        if (!dir) {
            continue;
        }
        for (const name of names) {
            const candidate = path.join(dir, name);
            if (fs.existsSync(candidate) && fs.statSync(candidate).isFile()) {
                return candidate;
            }
        }
    }
    return undefined;
}

async function downloadServer(context: vscode.ExtensionContext, versionSetting: string): Promise<string> {
    const asset = assetForPlatform(process.platform, process.arch);
    if (!asset) {
        throw new Error(`No st-lsp build for ${process.platform} ${process.arch}. Set st.languageServer.path to a local binary.`);
    }

    const storage = path.join(context.globalStorageUri.fsPath, 'st-lsp');
    const requested = versionSetting.trim() || 'latest';
    if (requested !== 'latest') {
        const pinned = path.join(storage, requested.replace(/^v/, ''), binaryName(process.platform));
        if (fs.existsSync(pinned)) {
            log(context, `Using cached ${pinned}`);
            return pinned;
        }
    }

    const releaseUrl = `https://api.github.com/repos/${repository}/${releaseApiPath(requested)}`;
    try {
        const release = await getJson(releaseUrl);
        const version = String(release.tagName ?? requested);
        const fileName = assetFileName(version, asset);
        const downloadUrl = release.assets.find((item) => item.name === fileName)?.downloadUrl;
        if (!downloadUrl) {
            throw new Error(`GitHub release ${version} has no asset ${fileName}.`);
        }

        const binary = path.join(storage, version.replace(/^v/, ''), binaryName(process.platform));
        if (fs.existsSync(binary)) {
            await rememberInstalled(storage, version);
            log(context, `Using cached ${binary}`);
            return binary;
        }

        await vscode.window.withProgress(
            {
                location: vscode.ProgressLocation.Notification,
                title: `Downloading st-lsp ${version}`,
            },
            () => installAsset(downloadUrl, path.dirname(binary), asset),
        );
        if (!fs.existsSync(binary)) {
            throw new Error(`Download of ${fileName} did not produce ${binaryName(process.platform)}.`);
        }
        await rememberInstalled(storage, version);
        log(context, `Installed ${binary}`);
        return binary;
    } catch (error) {
        const cached = await cachedBinary(storage, requested);
        if (cached) {
            const message = error instanceof Error ? error.message : String(error);
            log(context, `Download failed (${message}). Using cached ${cached}`);
            return cached;
        }
        throw error;
    }
}

async function rememberInstalled(storage: string, version: string): Promise<void> {
    await fs.promises.mkdir(storage, { recursive: true });
    await fs.promises.writeFile(path.join(storage, 'installed-version'), version, 'utf8');
}

async function cachedBinary(storage: string, requested: string): Promise<string | undefined> {
    const name = binaryName(process.platform);
    if (requested !== 'latest' && requested !== '') {
        const exact = path.join(storage, requested.replace(/^v/, ''), name);
        if (fs.existsSync(exact)) {
            return exact;
        }
        return undefined;
    }
    const marker = path.join(storage, 'installed-version');
    if (!fs.existsSync(marker)) {
        return undefined;
    }
    const version = (await fs.promises.readFile(marker, 'utf8')).trim().replace(/^v/, '');
    const binary = path.join(storage, version, name);
    return fs.existsSync(binary) ? binary : undefined;
}

async function installAsset(downloadUrl: string, destination: string, asset: StLspAsset): Promise<void> {
    await fs.promises.rm(destination, { recursive: true, force: true });
    await fs.promises.mkdir(destination, { recursive: true });
    const archivePath = path.join(destination, `st-lsp.${asset.archive === 'zip' ? 'zip' : 'tar.gz'}`);
    const bytes = await getBuffer(downloadUrl);
    await fs.promises.writeFile(archivePath, bytes);
    await execFile('tar', ['-xf', archivePath, '-C', destination]);
    await fs.promises.unlink(archivePath);
    const binary = await findBinary(destination, binaryName(process.platform));
    if (!binary) {
        throw new Error('The st-lsp archive does not contain the server executable.');
    }
    if (binary !== path.join(destination, binaryName(process.platform))) {
        await fs.promises.copyFile(binary, path.join(destination, binaryName(process.platform)));
    }
    if (process.platform !== 'win32') {
        await fs.promises.chmod(path.join(destination, binaryName(process.platform)), 0o755);
    }
}

async function findBinary(directory: string, name: string): Promise<string | undefined> {
    const direct = path.join(directory, name);
    if (fs.existsSync(direct)) {
        return direct;
    }
    const entries = await fs.promises.readdir(directory, { withFileTypes: true });
    for (const entry of entries) {
        if (!entry.isDirectory()) {
            continue;
        }
        const nested = path.join(directory, entry.name, name);
        if (fs.existsSync(nested)) {
            return nested;
        }
    }
    return undefined;
}

interface GithubRelease {
    tagName?: string;
    assets: { name?: string; downloadUrl?: string }[];
}

function getJson(url: string): Promise<GithubRelease> {
    const headers: Record<string, string> = {};
    headers['Accept'] = 'application/vnd.github+json';
    headers['User-Agent'] = 'vscode-st';
    return getBuffer(url, headers).then((body) => parseRelease(body.toString('utf8')));
}

function parseRelease(body: string): GithubRelease {
    const parsed: unknown = JSON.parse(body);
    const record = asRecord(parsed);
    const tagName = record?.['tag_name'];
    const rawAssets = record?.assets;
    const assets = Array.isArray(rawAssets) ? rawAssets : [];
    return {
        tagName: typeof tagName === 'string' ? tagName : undefined,
        assets: assets.map((item) => {
            const asset = asRecord(item);
            const name = asset?.name;
            const downloadUrl = asset?.['browser_download_url'];
            return {
                name: typeof name === 'string' ? name : undefined,
                downloadUrl: typeof downloadUrl === 'string' ? downloadUrl : undefined,
            };
        }),
    };
}

function asRecord(value: unknown): Record<string, unknown> | undefined {
    if (typeof value === 'object' && value !== null) {
        return value as Record<string, unknown>;
    }
    return undefined;
}

function getBuffer(url: string, headers?: Record<string, string>): Promise<Buffer> {
    const fallback: Record<string, string> = {};
    fallback['User-Agent'] = 'vscode-st';
    return request(url, headers ?? fallback, 0);
}

function request(urlStr: string, headers: Record<string, string>, redirects: number): Promise<Buffer> {
    return new Promise((resolve, reject) => {
        const url = new URL(urlStr);
        const req = https.get(url, { headers }, (res) => {
            const status = res.statusCode ?? 0;
            if (status >= 300 && status < 400 && res.headers.location) {
                res.resume();
                if (redirects >= 5) {
                    reject(new Error(`Too many redirects for ${urlStr}`));
                    return;
                }
                const next = new URL(res.headers.location, url).toString();
                resolve(request(next, headers, redirects + 1));
                return;
            }
            if (status !== 200) {
                res.resume();
                reject(new Error(`HTTP ${status} for ${urlStr}`));
                return;
            }
            const chunks: Buffer[] = [];
            res.on('data', (chunk: Buffer) => chunks.push(chunk));
            res.on('end', () => resolve(Buffer.concat(chunks)));
            res.on('error', reject);
        });
        req.on('error', reject);
        req.setTimeout(120_000, () => req.destroy(new Error(`Timed out downloading ${urlStr}`)));
    });
}

function execFile(command: string, args: string[]): Promise<void> {
    return new Promise((resolve, reject) => {
        cp.execFile(command, args, (error, _stdout, stderr) => {
            if (error) {
                reject(new Error(stderr?.toString().trim() || error.message));
                return;
            }
            resolve();
        });
    });
}
