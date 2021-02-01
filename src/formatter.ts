'use strict';
import * as vscode from 'vscode';

export class STFormatterProvider implements vscode.DocumentFormattingEditProvider {

    public out: Array<vscode.TextEdit> = [];

    provideDocumentFormattingEdits(document: vscode.TextDocument) {
        if (vscode.window.visibleTextEditors.every((e) => e.document.fileName !== document.fileName)) {
            return [];
        }

        this.out = [];

        this.capitalize(document);

        return this.out;
    }

    capitalize(document: vscode.TextDocument) {
        let text = document.getText();

        let keywords = [
            'true', 'false', 'exit', 'continue', 'return', 'constant', 'retain',
            'public', 'private', 'protected', 'abstract', 'persistent', 'internal',
            'final', 'of', 'else', 'elsif', 'then', '__try', '__catch', '__finally',
            '__endtry', 'do', 'to', 'by', 'task', 'with', 'using', 'uses', 'from',
            'until', 'or', 'or_else', 'and', 'and_then', 'not', 'xor', 'nor', 'ge',
            'le', 'eq', 'ne', 'gt', 'lt', 'extends', 'implements', 'this', 'super',
            '__new', '__delete',
            '(?:T|DT|TOD|D)#[0-9\\:\\-\\_yYmMdDhHsS]+',
            'var_(input|output|in_out|temp|global|access|external)'
        ];

        let types = [
            'AT', 'BOOL', 'BYTE', '(?:D|L)?WORD', 'U?(?:S|D|L)?INT', 'L?REAL', 
            'TIME(?:_OF_DAY)?', 'TOD', 'DT', 'DATE(?:_AND_TIME)?', 'W?STRING', 
            'ARRAY', 'ANY', 'ANY_(?:NUM|INT|REAL)'];

        let end = [
            'var', 'program', 'if', 'case', 'while', 'for', 'repeat', 'function',
            'function_block', 'struct', 'configuration', 'tcp', 'resource',
            'channel', 'library', 'folder', 'binaries', 'includes', 'sources',
            'action', 'step', 'initial_step', 'transition', 'type', 'namespace',
            'implementation', 'interface', 'property', 'method', 'union'
        ];

        let functions = [
            'abs', 'sin', 'mod', 'abs', 'acos', 'asin', 'atan', 'cos', 'exp',
            'expt', 'ln', 'log', 'sin', 'sqrt', 'tan', 'sel', 'mux', 'shl',
            'shr', 'rol', 'ror', 'add', 'div', 'mul', 'sub', 'limit', 'max',
            'min', 'adr', 'adrinst', 'size', 'sizeof', 'bit_adr', 'bit_trunc',
            'rs', 'sr', 'ton', 'tp', 'tof', 'trunc', 'ctd', 'ctu', 'ctud', 'r_trig',
            'f_trig', 'move', 'concat', 'delete', 'find', 'insert', 'left', 'len',
            'replace', 'right', 'rtc', 'mid', 'sema', 'round', 'floor', 'ceil',
            'unpack', 'ref', '__new', '__delete',

            '[A-Za-z_]*(_TO_)[A-Za-z_]*', '(?:TO_|FROM_|TRUNC_)[A-Za-z_]*'
        ];
        
        let regEx = new RegExp(`\\b(?:${functions.join('|')})\\b\\s+\\(`, "ig");
        text = text.replace(regEx, (match) => {
            return match.replace(/\s+/, '');
        });


        regEx = new RegExp(`(?<!\\\\(?:\\\\{2})*)["']{1}[^"'\\\\]*(?:\\\\[\\s\\S][^\\\\"']*)*["']{1}|\\(\\*[\\s\\S]*?\\*\\)|\\/\\*[\\s\\S]*?\\*\\/|\\/\\/[^\\n]*\\n|\\b(${types.join('|')}|${keywords.join('|')}|(?:END_)?(?:${end.join('|')})|${functions.join('\\(|')}\\()\\b`, "ig");
        text = text.replace(regEx, (match, group) => {
            return group != undefined ? match.toUpperCase() : match;
        });

        this.out.push(
            new vscode.TextEdit(new vscode.Range(
                new vscode.Position(0, 0),
                document.lineAt(document.lineCount - 1).range.end), text
            )
        );
    }
}
