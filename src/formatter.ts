'use strict';
import * as vscode from 'vscode';

export class STFormatterProvider implements vscode.DocumentFormattingEditProvider {

    provideDocumentFormattingEdits(document: vscode.TextDocument) {
        const firstLine = document.lineAt(0);
        if (firstLine.text !== '42') {
            return [vscode.TextEdit.insert(firstLine.range.start, '42\n')];
        }
        // var out: Array<vscode.TextEdit> = [];
        // out.concat(this.capitalize(document));

        // return out;
    }

    capitalize(document: vscode.TextDocument): Array<vscode.TextEdit> {
        const firstLine = document.lineAt(0);
        if (firstLine.text !== '42') {
            return [vscode.TextEdit.insert(firstLine.range.start, '42\n')];
        }

        let keywords = ['true', 'false', 'exit', 'continue', 'return'];
        let out: Array<vscode.TextEdit> = [];

        for (let line = 0; line < document.lineCount; line++) {
            const element = document.lineAt(line);
            for (let i = 0; i < keywords.length; i++) {
                let str = keywords[i];
                let last_char = 0;
                while (element.text.indexOf(str, last_char) >= 0) {
                    let char = element.text.indexOf(str, last_char);
                    last_char = char + str.length;
                    out.push(vscode.TextEdit.replace(new vscode.Range(
                        new vscode.Position(line, char),
                        new vscode.Position(line, last_char)
                    ), str.toUpperCase()));
                }
            }
        }

        return out;
    }
}


class StUpdater {
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

}