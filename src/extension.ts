'use strict';

import * as vscode from 'vscode';

import { stDocumentSymbolProvider } from './symbolprovider';

export function activate(context: vscode.ExtensionContext) {

    if (!vscode.window.activeTextEditor) {
        vscode.window.showInformationMessage('Open a file first to manipulate text selections');
        return;
    }

    let Updater = new StUpdater();
    //let UpdaterControl = new StUpdaterController(Updater);
    context.subscriptions.push(new StUpdaterController(Updater));
    //context.subscriptions.push(Updater);

    context.subscriptions.push(vscode.commands.registerCommand('extension.st.autoformat', () => {
        Updater.Update(true);
    }));
    
    context.subscriptions.push(vscode.languages.registerDocumentSymbolProvider(
        { language: "st" }, new stDocumentSymbolProvider()
    ));
}

export function deactivate() {
}

export class StUpdater {
    private _lines: number;
    private _strings: Array<string>;

    constructor() {
        this._lines = 0;
        this._strings = ['true', 'false', 'exit', 'continue', 'return'];
    }

    Update(Cntx: boolean = false) {
        let editor = vscode.window.activeTextEditor;
        if (!editor || (editor.document.languageId !== 'st')) {
            return;
        }

        let doc = editor.document;

        if (Cntx === false) {
            if (this._lines >= doc.lineCount) {
                this._lines = doc.lineCount;
                return;
            }
            this._lines = doc.lineCount;

            let AutoFormat = vscode.workspace.getConfiguration('st').get('format.enable');

            if (!AutoFormat) {
                return;
            }
        }


        let edit = new vscode.WorkspaceEdit();

        for (let line = 0; line < doc.lineCount; line++) {
            const element = doc.lineAt(line);
            for (let i = 0; i < this._strings.length; i++) {
                let str = this._strings[i];
                let last_char = 0;
                while (element.text.indexOf(str, last_char) >= 0) {
                    let char = element.text.indexOf(str, last_char);
                    last_char = char + str.length;
                    edit.replace(
                        doc.uri,
                        new vscode.Range(
                            new vscode.Position(line, char),
                            new vscode.Position(line, last_char)
                        ),
                        str.toUpperCase()
                    );
                }
            }
        }

        return vscode.workspace.applyEdit(edit);
    }

    public dispose() {

    }
}

class StUpdaterController {
    private _StUpdater: StUpdater;
    private _Disposable: vscode.Disposable;

    constructor(updater: StUpdater) {
        this._StUpdater = updater;
        this._StUpdater.Update();

        let subscriptions: vscode.Disposable[] = [];
        vscode.window.onDidChangeTextEditorSelection(this._onEvent, this, subscriptions);

        this._Disposable = vscode.Disposable.from(...subscriptions);
    }

    public _onEvent() {
        this._StUpdater.Update();
    }

    public dispose() {
        this._Disposable.dispose();
    }
}
