export interface StLspAsset {
    os: 'windows' | 'linux' | 'macos';
    arch: 'x86_64' | 'aarch64';
    archive: 'zip' | 'tar.gz';
}

export function binaryName(platform: NodeJS.Platform): string {
    return platform === 'win32' ? 'st-lsp.exe' : 'st-lsp';
}

/**
 * Asset names published by kropochev/st-lsp.
 * Windows on ARM uses the x86_64 build. macOS Intel has no published build.
 */
export function assetForPlatform(platform: NodeJS.Platform, arch: string): StLspAsset | undefined {
    if (platform === 'win32') {
        if (arch === 'x64' || arch === 'arm64') {
            return { os: 'windows', arch: 'x86_64', archive: 'zip' };
        }
        return undefined;
    }
    if (platform === 'linux') {
        if (arch === 'x64') {
            return { os: 'linux', arch: 'x86_64', archive: 'tar.gz' };
        }
        if (arch === 'arm64') {
            return { os: 'linux', arch: 'aarch64', archive: 'tar.gz' };
        }
        return undefined;
    }
    if (platform === 'darwin' && arch === 'arm64') {
        return { os: 'macos', arch: 'aarch64', archive: 'tar.gz' };
    }
    return undefined;
}

export function assetFileName(version: string, asset: StLspAsset): string {
    const normalized = version.trim().replace(/^v/, '');
    return `st-lsp-${normalized}-${asset.os}-${asset.arch}.${asset.archive}`;
}

export function releaseApiPath(version: string): string {
    const trimmed = version.trim();
    if (trimmed === '' || trimmed === 'latest') {
        return 'releases/latest';
    }
    const tag = trimmed.startsWith('v') ? trimmed : `v${trimmed}`;
    return `releases/tags/${tag}`;
}
