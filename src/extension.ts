'use strict';

//import * as vscode from 'vscode';
import { window, workspace, commands, Disposable, ExtensionContext, TextEdit, Position, Range, WorkspaceEdit } from 'vscode';

export function activate(context: ExtensionContext) {

    if (!window.activeTextEditor) {
        window.showInformationMessage('Open a file first to manipulate text selections');
        return;
    }
    let Updater = new StUpdater();
    let UpdaterControl = new StUpdaterController(Updater);
    context.subscriptions.push(UpdaterControl);
    context.subscriptions.push(Updater);

    let disposable = commands.registerCommand('extension.st.autoformat', () => {
        Updater.Update(true);
    });

    context.subscriptions.push(disposable);
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
        let editor = window.activeTextEditor;
        if (!editor || (editor.document.languageId != 'st')) {
            window.showErrorMessage('No editor!')
            return;
        }

        let doc = editor.document;

        if (Cntx == false) {
            if (this._lines >= doc.lineCount) {
                this._lines = doc.lineCount;
                return;
            }
            this._lines = doc.lineCount;

            let AutoFormat = workspace.getConfiguration('st').get('format.enable');

            if (!AutoFormat) {
                return;
            }
        }


        let edit = new WorkspaceEdit();
        
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
                        new Range(
                            new Position(line, char),
                            new Position(line, last_char)
                        ),
                        str.toUpperCase()
                    );
                }
            }
        }

        return workspace.applyEdit(edit);
    }

    public dispose() {

    }
}

class StUpdaterController {
    private _StUpdater: StUpdater;
    private _Disposable: Disposable;

    constructor(updater: StUpdater) {
        this._StUpdater = updater;
        this._StUpdater.Update();

        let subscriptions: Disposable[] = [];
        window.onDidChangeTextEditorSelection(this._onEvent, this, subscriptions);
        //window.onDidChangeActiveTextEditor(this._onEvent, this, subscriptions);

        this._Disposable = Disposable.from(...subscriptions);
    }

    public _onEvent() {
        this._StUpdater.Update();
    }

    public dispose() {
        this._Disposable.dispose();
    }
}
