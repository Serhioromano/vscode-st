'use strict';

import * as vscode from 'vscode';

export function activate(context: vscode.ExtensionContext) {

    let AutoFormat = vscode.workspace.getConfiguration('st').get('autoFormat');


    // Autoformat on command
    let disposable = vscode.commands.registerCommand('extension.st.autoformat', () => {
        vscode.window.showInformationMessage('Hello World!');
    });

    context.subscriptions.push(disposable);
}

export function deactivate() {
}