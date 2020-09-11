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
            'public', 'private', 'protected', 'abstract','persistent','internal',
            'final','of','else','elsif','then','__try','__catch','__finally',
            '__endtry','do','to','by','task','with','using','uses','from',
            'until','or','or_else','and','and_then','not','xor','nor','ge',
            'le','eq','ne','gt','lt','__new','__delete', 'extends','implements',
            'this','super'
        ];
        let regEx = new RegExp(`\\b(?:${keywords.join('|')}|AT|BOOL|BYTE|(?:D|L)?WORD|U?(?:S|D|L)?INT|L?REAL|TIME(?:_OF_DAY)?|TOD|DT|DATE(?:_AND_TIME)?|STRING|ARRAY|ANY)\\b`, "ig");
        text = text.replace(regEx, (match) => {
            return match.toUpperCase();
        });
        
        regEx = new RegExp("\\b[A-Za-z_]*(_TO_)[A-Za-z_]*\\b", "ig");
        text = text.replace(regEx, (match) => {
            return match.toUpperCase();
        });
        regEx = new RegExp("\\b(TO_|FROM_|TRUNC_)[A-Za-z_]*\\b", "ig");
        text = text.replace(regEx, (match) => {
            return match.toUpperCase();
        });

        let end = [
            'var', 'program', 'if', 'case', 'while', 'for', 'repeat', 'function',
            'function_block', 'struct', 'configuration', 'tcp', 'resource',
            'channel', 'library', 'folder', 'binaries', 'includes', 'sources',
            'action', 'step', 'initial_step', 'transition', 'type', 'namespace',
            'implementation', 'interface', 'property', 'method'
        ];
        regEx = new RegExp(`\\b(?:END_)?(?:${end.join('|')})\\b`, "ig");
        text = text.replace(regEx, (match) => {
            return match.toUpperCase();
        });

        let functions = [
            'abs', 'sin', 'mod', 'abs', 'acos', 'asin', 'atan', 'cos', 'exp',
            'expt', 'ln', 'log', 'sin', 'sqrt', 'tan', 'sel', 'mux', 'shl',
            'shr', 'rol', 'ror', 'add', 'div', 'mul', 'sub', 'limit', 'max',
            'min', 'adr', 'adrinst', 'size', 'sizeof', 'bit_adr', 'bit_trunc',
            'rs', 'sr', 'ton', 'tp', 'tof', 'trunc', 'ctd', 'ctu', 'ctud', 'r_trig',
            'f_trig', 'move', 'concat', 'delete', 'find', 'insert', 'left', 'len',
            'replace', 'right', 'rtc', 'mid', 'sema', 'round', 'floor', 'ceil',
            'unpack', 'ref'
        ];

        regEx = new RegExp(`\\b(?:${functions.join('|')})\\b\\s+\\(`, "ig");
        text = text.replace(regEx, (match) => {
            return match.replace(/\s+/, '');
        });

        regEx = new RegExp(`\\b(?:${functions.join('|')})\\(`, "ig");
        text = text.replace(regEx, (match) => {
            return match.toUpperCase();
        });

        this.out.push(
            new vscode.TextEdit(new vscode.Range(
                new vscode.Position(0, 0),
                document.lineAt(document.lineCount - 1).range.end), text
            )
        );
    }
}
