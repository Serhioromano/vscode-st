'use strict';

import * as vscode from 'vscode';

import { startLanguageServer, stopLanguageServer } from './languageServer';

export async function activate(context: vscode.ExtensionContext): Promise<void> {
    context.subscriptions.push(
        vscode.commands.registerCommand('st.restartLanguageServer', () => startLanguageServer(context)),
        vscode.workspace.onDidChangeConfiguration((event) => {
            if (event.affectsConfiguration('st.languageServer.enable')
                || event.affectsConfiguration('st.languageServer.path')
                || event.affectsConfiguration('st.languageServer.version')
                || event.affectsConfiguration('st.languageServer.formatting')) {
                void startLanguageServer(context);
            }
        }),
    );
    await startLanguageServer(context);
}

export function deactivate(): Thenable<void> {
    return stopLanguageServer();
}
