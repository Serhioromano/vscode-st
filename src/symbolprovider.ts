'use strict';
import * as vscode from 'vscode';

export class stDocumentSymbolProvider implements vscode.DocumentSymbolProvider {

    public provideDocumentSymbols(document: vscode.TextDocument, token: vscode.CancellationToken): Promise<vscode.DocumentSymbol[]> {
        return new Promise((resolve, reject) => {
            let symbols: vscode.DocumentSymbol[] = [];

            let doc = document.getText();
            let m;

            let regex = /\bprogram\s*\b([a-zA-Z0-9_]*)\b([\s\S]*?)\bend_program\b/img;
            while ((m = regex.exec(doc)) !== null) {
                let ln = this.getLineNum(doc, m[0]);
                let range = this.getRange(ln);
                let item = new vscode.DocumentSymbol(
                    m[1], 'Program',
                    vscode.SymbolKind.Constructor,
                    range, range
                );
                    
                let var_local = this.getVar('VAR', m[0], doc, ln, 'Local variables');
                if (var_local !== null) {
                    item.children.push(var_local);
                }
                let var_temp = this.getVar('VAR_TEMP', m[0], doc, ln, 'Local variables');
                if (var_temp !== null) {
                    item.children.push(var_temp);
                }
                let var_input = this.getVar('VAR_INPUT', m[0], doc, ln, 'Input variables');
                if (var_input !== null) {
                    item.children.push(var_input);
                }
                let var_output = this.getVar('VAR_OUTPUT', m[0], doc, ln, 'Output variables');
                if (var_output !== null) {
                    item.children.push(var_output);
                }
                let var_in_out = this.getVar('VAR_IN_OUT', m[0], doc, ln, 'Through variables');
                if (var_in_out !== null) {
                    item.children.push(var_in_out);
                }
                
                symbols.push(item);
            }

            regex = /\btype\b([\s\S]*?)\bend_type\b/img;
            while ((m = regex.exec(doc)) !== null) {
                let rgx_struct = /\b([a-zA-Z0-9_]*)\b\s*:\s*struct([\s\S]*?)end_struct/img;
                let ms : RegExpExecArray | null;
                while ((ms = rgx_struct.exec(m[0])) !== null) {
                    let ln = this.getLineNum(doc, ms[0]);
                    let range = this.getRange(ln);
                    let item = new vscode.DocumentSymbol(
                        ms[1], 'Structure',
                        vscode.SymbolKind.Struct,
                        range, range
                    );
                    let vars = this.listVariables(ms[0], ln);
                    if (vars !== null) {
                        item.children = vars;
                    }
                    symbols.push(item);
                }
                
                let rgx_enum = /\b([a-zA-Z0-9_]*)\b\s*:\s*\(([\s\S]*?)\)\s*;/img;
                while ((ms = rgx_enum.exec(m[0])) !== null) {
                    let ln = this.getLineNum(doc, ms[0]);
                    let range = this.getRange(ln);
                    let item = new vscode.DocumentSymbol(
                        ms[1], 'Enumeration',
                        vscode.SymbolKind.Enum,
                        range, range
                    );
                    let enums = ms[2].split(',');
                    let contx = ms[2];
                    // TODO: Better get every parameter
                    enums.forEach(element => {
                        let emm = element.match(/^\s*\b([A-Za-z_0-9]*)\b/);
                        if (emm === null) {
                            emm = element.match(/\b([A-Za-z_0-9]*)\b\s*(:=\s*[0-9]*)?\s*$/);
                        }
                        if (emm !== null) {
                            let en_ln = this.getLineNum(contx, element);
                            let range = this.getRange(ln + (en_ln > 0 ? en_ln + 1 : en_ln));
                                let e = new vscode.DocumentSymbol(
                                emm[1], 'Enumerator',
                                vscode.SymbolKind.Variable,
                                range, range
                            );
                            item.children.push(e);
                        }
                    });

                    symbols.push(item);
                }
                
            }
           
            regex = /\bfunction_block\s*\b([a-zA-Z0-9_]*)\b([\s\S]*?)\bend_function_block\b/img;
            while ((m = regex.exec(doc)) !== null) {
                let ln = this.getLineNum(doc, m[0]);
                let range = this.getRange(ln);
                let item = new vscode.DocumentSymbol(
                    m[1], 'Function block',
                    vscode.SymbolKind.Module,
                    range, range
                );
                    
                let var_local = this.getVar('VAR', m[0], doc, ln, 'Local variables');
                if (var_local !== null) {
                    item.children.push(var_local);
                }
                let var_temp = this.getVar('VAR_TEMP', m[0], doc, ln, 'Local variables');
                if (var_temp !== null) {
                    item.children.push(var_temp);
                }
                let var_input = this.getVar('VAR_INPUT', m[0], doc, ln, 'Input variables');
                if (var_input !== null) {
                    item.children.push(var_input);
                }
                let var_output = this.getVar('VAR_OUTPUT', m[0], doc, ln, 'Output variables');
                if (var_output !== null) {
                    item.children.push(var_output);
                }
                let var_in_out = this.getVar('VAR_IN_OUT', m[0], doc, ln, 'Through variables');
                if (var_in_out !== null) {
                    item.children.push(var_in_out);
                }
                
                symbols.push(item);
            }

            regex = /\bfunction\s*\b([a-zA-Z0-9_]*)\b\s*:\s*\b([a-zA-Z0-9_]*)\b([\s\S]*?)end_function/img;
            while ((m = regex.exec(doc)) !== null) {
                let ln = this.getLineNum(doc, m[0]);
                let range = this.getRange(ln);
                let item = new vscode.DocumentSymbol(
                    m[1] + " (" + m[2] + ")", 'Function',
                    vscode.SymbolKind.Function,
                    range, range
                );
                    
                let var_local = this.getVar('VAR', m[0], doc, ln, 'Local variables');
                if (var_local !== null) {
                    item.children.push(var_local);
                }
                let var_temp = this.getVar('VAR_TEMP', m[0], doc, ln, 'Local variables');
                if (var_temp !== null) {
                    item.children.push(var_temp);
                }
                let var_input = this.getVar('VAR_INPUT', m[0], doc, ln, 'Input variables');
                if (var_input !== null) {
                    item.children.push(var_input);
                }
                let var_output = this.getVar('VAR_OUTPUT', m[0], doc, ln, 'Output variables');
                if (var_output !== null) {
                    item.children.push(var_output);
                }
                let var_in_out = this.getVar('VAR_IN_OUT', m[0], doc, ln, 'Through variables');
                if (var_in_out !== null) {
                    item.children.push(var_in_out);
                }
                
                symbols.push(item);
            }
                
            resolve(symbols);
        });
    }
            
    private getVar(vars:string, scope: string, doc: string, ln: number, description: string): vscode.DocumentSymbol | null {
        let symbols: vscode.DocumentSymbol[] = [];
        let regex = new RegExp('\\b' + vars + "\\b([\\s\\S]*?)end_var\\b","img");
        let m = scope.match(regex);
        if (m !== null) {
            let ln2 = this.getLineNum(scope, m[0]);
            symbols = this.listVariables(m[0], ln + ln2);

            if(symbols.length > 0 ) {
                let range = this.getRange(this.getLineNum(doc, m[0]));
                let child = new vscode.DocumentSymbol(vars, description, vscode.SymbolKind.Constructor, range, range);
                child.children = symbols;
                return child;
            }
    
        }
      
        return null;
    }

    private listVariables(text: string, ln: number) : vscode.DocumentSymbol[] {
        let symbols: vscode.DocumentSymbol[] = [];
        let lines = text.split('\n');
        lines.forEach((line, key) => {
            let variables = line.match(/\b([a-zA-Z0-9_]*)\b\s*(.*)?\s*:\s*\b([a-zA-Z0-9_]*)\b([\s\S]*);\s*(\(\*(.*)\*\))?/);
            if(variables !== null) {
                let range = this.getRange(key + ln);
                if(variables !== null && variables.length > 1) {
                    let item = new vscode.DocumentSymbol(
                        variables[1] + ' (' + variables[3] + ') ' + (variables[2] !== undefined ? variables[2] : ''), variables[6] || 'Variable',
                        vscode.SymbolKind.Variable,
                        range, range
                    );
                        
                    symbols.push(item);
                }
            }
        });
        return symbols;
    }

    private getLineNum(text: string, substring: string) : number {
        var index = text.indexOf(substring);
        var tempString = text.substring(0, index);
        return tempString.split('\n').length - 1;
    }
    private getRange(ln: number): vscode.Range {
        let pos1 = new vscode.Position(ln, 0);
        let pos2 = new vscode.Position(ln, 1);
        return new vscode.Range(pos1, pos2);
    }
}