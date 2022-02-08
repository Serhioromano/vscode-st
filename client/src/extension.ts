"use strict";

import * as vscode from "vscode";
import * as path from "path";

import { STDocumentSymbolProvider } from "./symbolprovider";
import { STFormatterProvider } from "./formatter";

import { LanguageClient, LanguageClientOptions, ServerOptions, TransportKind } from "vscode-languageclient/node";

let client: LanguageClient;

export function activate(context: vscode.ExtensionContext) {
    context.subscriptions.push(vscode.languages.registerDocumentFormattingEditProvider("st", new STFormatterProvider()));

    context.subscriptions.push(
        vscode.languages.registerDocumentSymbolProvider({ language: "st" }, new STDocumentSymbolProvider())
    );

    const serverModule = context.asAbsolutePath(path.join("server", "out", "server.js"));
    const debugOptions = { execArgv: ["--nolazy", "--inspect=6009"] };

    const serverOptions: ServerOptions = {
        run: { module: serverModule, transport: TransportKind.ipc },
        debug: {
            module: serverModule,
            transport: TransportKind.ipc,
            options: debugOptions,
        },
    };

    const clientOptions: LanguageClientOptions = {
        documentSelector: [{ scheme: "file", language: "st" }],
        synchronize: {
            fileEvents: vscode.workspace.createFileSystemWatcher("**/.clientrc"),
        },
    };

    client = new LanguageClient(
        "STlanguageServer",
        "Language Server for Structured Text",
        serverOptions,
        clientOptions
    );
    client.start();
}

export function deactivate() {
    if (!client) {
        return undefined;
    }
    return client.stop();
}
