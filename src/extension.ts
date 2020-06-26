'use strict';

import * as vscode from 'vscode';

import { STDocumentSymbolProvider } from './symbolprovider';
import { STFormatterProvider } from './formatter';

export function activate(context: vscode.ExtensionContext) {

    // if (!vscode.window.activeTextEditor) {
    //     vscode.window.showInformationMessage('Open a file first to manipulate text selections');
    //     return;
    // }

    vscode.languages.registerDocumentFormattingEditProvider('st', new STFormatterProvider());
    
    context.subscriptions.push(vscode.languages.registerDocumentSymbolProvider(
        { language: "st" }, new STDocumentSymbolProvider()
    ));
}

export function deactivate() {
}
