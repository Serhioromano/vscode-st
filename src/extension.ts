'use strict';

//import * as vscode from 'vscode';
import { window, workspace, commands, Disposable, ExtensionContext, TextDocument, Position, Range } from 'vscode';

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
        if (!editor) {
            window.showErrorMessage('No editor!')
            return;
        }

        let doc = editor.document;

        if (doc.languageId != "st") {
            window.showErrorMessage('This file is not a structured text language!')
            return;
        }

        if (Cntx == false) {
            if (this._lines >= doc.lineCount) {
                this._lines = doc.lineCount;
                return;
            }
            this._lines = doc.lineCount;

            let AutoFormat = workspace.getConfiguration('st').get('autoFormat');

            if (!AutoFormat) {
                return;
            }
        }


        editor.edit((edit) => {
            let lines = doc.getText().split('\n');
            for (let line = 0; line < lines.length; line++) {
                const element = lines[line];
                for (let i = 0; i < this._strings.length; i++) {
                    let str = this._strings[i];
                    let char = element.indexOf(str);
                    if (char >= 0) {
                        //console.log(line, char);
                        edit.replace(
                            new Range(
                                new Position(line, char),
                                new Position(line, char + str.length)
                            ),
                            str.toUpperCase()
                        );
                    }
                }

            }
        });
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
