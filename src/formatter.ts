'use strict';
import * as vscode from 'vscode';

export class STFormatterProvider implements vscode.DocumentFormattingEditProvider {

    public out: Array<vscode.TextEdit> = [];

    provideDocumentFormattingEdits(document: vscode.TextDocument) {
        this.capitalize(document);

        return this.out;
    }

    capitalize(document: vscode.TextDocument) {
        let keywords = ['true', 'false', 'exit', 'continue', 'return', 'constant', 'retain'];

        for (let line = 0; line < document.lineCount; line++) {
            const element = document.lineAt(line);
            for (let i = 0; i < keywords.length; i++) {
                let str = keywords[i];
                let last_char = 0;
                while (element.text.indexOf(str, last_char) >= 0) {
                    let char = element.text.indexOf(str, last_char);
                    last_char = char + str.length;
                    this.out.push(vscode.TextEdit.replace(new vscode.Range(
                        new vscode.Position(line, char),
                        new vscode.Position(line, last_char)
                    ), str.toUpperCase()));
                }
            }
        }
    }
}
