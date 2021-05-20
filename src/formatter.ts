'use strict';
import * as vscode from 'vscode';

export class STFormatterProvider implements vscode.DocumentFormattingEditProvider {
    private functions: Array<string> = [];
    private keywords: Array<string> = [];
    private types: Array<string> = [];
    private ends: Array<string> = [];

    provideDocumentFormattingEdits(document: vscode.TextDocument) {
        if (vscode.window.visibleTextEditors.every((e) => e.document.fileName !== document.fileName)) {
            return [];
        }

        let out = [];
        this.functions = [
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

        this.keywords = [
            'true', 'false', 'exit', 'continue', 'return', 'constant', 'retain',
            'public', 'private', 'protected', 'abstract', 'persistent', 'internal',
            'final', 'of', 'else', 'elsif', 'then', '__try', '__catch', '__finally',
            '__endtry', 'do', 'to', 'by', 'task', 'with', 'using', 'uses', 'from',
            'until', 'or', 'or_else', 'and', 'and_then', 'not', 'xor', 'nor', 'ge',
            'le', 'eq', 'ne', 'gt', 'lt', 'extends', 'implements', 'this', 'super',
            '(?:T|DT|TOD|D)#[0-9\\:\\-\\_yYmMdDhHsS]+',
            'var_(input|output|in_out|temp|global|access|external)'
        ];

        this.types = [
            'AT', 'BOOL', 'BYTE', '(?:D|L)?WORD', 'U?(?:S|D|L)?INT', 'L?REAL',
            'TIME(?:_OF_DAY)?', 'TOD', 'DT', 'DATE(?:_AND_TIME)?', 'W?STRING',
            'ARRAY', 'ANY', 'ANY_(?:NUM|INT|REAL)'];

        this.ends = [
            'var', 'program', 'if', 'case', 'while', 'for', 'repeat', 'function',
            'function_block', 'struct', 'configuration', 'tcp', 'resource',
            'channel', 'library', 'folder', 'binaries', 'includes', 'sources',
            'action', 'step', 'initial_step', 'transition', 'type', 'namespace',
            'implementation', 'interface', 'property', 'method', 'union'
        ];

        let text = document.getText();

        text = this.spaces(text);
        text = this.capitalize(text);

        out.push(
            new vscode.TextEdit(new vscode.Range(
                new vscode.Position(0, 0),
                document.lineAt(document.lineCount - 1).range.end), text
            )
        );

        return out;
    }

    spaces(text: string): string {
        let regEx = new RegExp(`\\b(?:${this.functions.join('|')})\\b\\s+\\(`, "ig");
        text = text.replace(regEx, (match) => {
            return match.replace(/\s+/, '');
        });

        regEx = new RegExp(`\\b(IF|WHILE|CASE)\\(`, "ig");
        text = text.replace(regEx, (match, key) => {
            return key !== undefined ? key + ' (' : match;
        });

        regEx = new RegExp(`\\)(THEN|DO|OF)\\b`, "ig");
        text = text.replace(regEx, (match, key) => {
            return key !== undefined ? ') ' + key : match;
        });

        regEx = new RegExp(`\\b([a-zA-Z0-9_]*)(:=|=>)`, "ig");
        text = text.replace(regEx, (match, key, sign) => {
            return key !== undefined && sign !== undefined ? key + " " + sign : match;
        });

        regEx = new RegExp(`(:=|=>)((?:\\(|\\'|\\"|\\[)?[a-zA-Z0-9_]*)\\b`, "ig");
        text = text.replace(regEx, (match, sign, key) => {
            return key !== undefined && sign !== undefined ? sign + " " + key : match;
        });

        let spB = ['\\*\\)', '\\*\\/', '\\{'];
        let spA = ['\\(\\*', '\\/\\*', '\\}', '\\/\\/', ','];
        let spBA = ['<', '>', '=', '\\+', '\\-', ':', '\\*', '\\/'];

        console.log(`(${spA.join('|')}|${spBA.join('|')})([^\\s]{1})`);
        
        regEx = new RegExp(`(${spA.join('|')}|${spBA.join('|')})([^\\s]{1})`, "ig");
        text = text.replace(regEx, (match, sign, key) => {
            return key !== undefined && sign !== undefined ? sign + " " + key : match;
        });
        regEx = new RegExp(`([^\\s])(${spB.join('|')}|${spBA.join('|')})`, "ig");
        text = text.replace(regEx, (match, key, sign) => {
            return key !== undefined && sign !== undefined ? key + " " + sign : match;
        });

        let from = [': =', '= >', '< =', '> =', '\\/ \\*', '\\* \\/',  '\\( \\*', '\\* \\)', '\\/ \\/'];
        let to = [':=', '=>', '<=', '>=', '/*', '*/',  '(*', '*)', '//'];
        for (let i = 0; i < from.length; i++) {
            text = text.replace(new RegExp(from[i], "g"), to[i]);
        }

        return text;
    }

    capitalize(text: string): string {
        let regEx = new RegExp(`(?<!\\\\(?:\\\\{2})*)["']{1}[^"'\\\\]*(?:\\\\[\\s\\S][^\\\\"']*)*["']{1}|\\(\\*[\\s\\S]*?\\*\\)|\\/\\*[\\s\\S]*?\\*\\/|\\/\\/[^\\n]*\\n|\\b(${this.types.join('|')}|${this.keywords.join('|')}|(?:END_)?(?:${this.ends.join('|')})|${this.functions.join('\\(|')}\\()\\b`, "ig");
        text = text.replace(regEx, (match, group) => {
            return group !== undefined ? match.toUpperCase() : match;
        });

        return text;
    }
}
