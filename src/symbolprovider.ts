'use strict';
import * as vscode from 'vscode';

export class stDocumentSymbolProvider implements vscode.DocumentSymbolProvider {

    public provideDocumentSymbols(document: vscode.TextDocument, token: vscode.CancellationToken): Promise<vscode.DocumentSymbol[]> {
        return new Promise((resolve, reject) => {
            let symbols: vscode.DocumentSymbol[] = [];

            let doc = document.getText();
            let m;

            let regex = /^(?<=\s*)\bprogram\s*\b([a-zA-Z0-9_]*)\b([\s\S]*?)end_program$/img;
            while ((m = regex.exec(doc)) !== null) {
                let range = this.getRange(doc, m[0]);
                let item = new vscode.DocumentSymbol(
                    m[1], 'Program',
                    vscode.SymbolKind.Constructor,
                    range, range
                );
                    
                let var_local = this.getVar('VAR', m[0], doc, 'Local variables');
                if (var_local !== null) {
                    item.children.push(var_local);
                }
                let var_input = this.getVar('VAR_INPUT', m[0], doc, 'Input variables');
                if (var_input !== null) {
                    item.children.push(var_input);
                }
                let var_output = this.getVar('VAR_OUTPUT', m[0], doc, 'Output variables');
                if (var_output !== null) {
                    item.children.push(var_output);
                }
                let var_in_out = this.getVar('VAR_IN_OUT', m[0], doc, 'Through variables');
                if (var_in_out !== null) {
                    item.children.push(var_in_out);
                }
                
                symbols.push(item);
            }
            
            regex = /^(?<=\s*)\bfunction_block\s*\b([a-zA-Z0-9_]*)\b([\s\S]*?)end_function_block$/img;
            while ((m = regex.exec(doc)) !== null) {
                let range = this.getRange(doc, m[0]);
                let item = new vscode.DocumentSymbol(
                    m[1], 'Function block',
                    vscode.SymbolKind.Module,
                    range, range
                );
                    
                let var_local = this.getVar('VAR', m[0], doc, 'Local variables');
                if (var_local !== null) {
                    item.children.push(var_local);
                }
                let var_input = this.getVar('VAR_INPUT', m[0], doc, 'Input variables');
                if (var_input !== null) {
                    item.children.push(var_input);
                }
                let var_output = this.getVar('VAR_OUTPUT', m[0], doc, 'Output variables');
                if (var_output !== null) {
                    item.children.push(var_output);
                }
                let var_in_out = this.getVar('VAR_IN_OUT', m[0], doc, 'Through variables');
                if (var_in_out !== null) {
                    item.children.push(var_in_out);
                }
                
                symbols.push(item);
            }

            regex = /^(?<=\s*)\bfunction\s*\b([a-zA-Z0-9_]*)\b\s*:\s*\b([a-zA-Z0-9_]*)\b([\s\S]*?)end_function$/img;
            while ((m = regex.exec(doc)) !== null) {
                let range = this.getRange(doc, m[0]);
                let item = new vscode.DocumentSymbol(
                    m[1] + " (" + m[2] + ")", 'Function',
                    vscode.SymbolKind.Function,
                    range, range
                );
                    
                let var_local = this.getVar('VAR', m[0], doc, 'Local variables');
                if (var_local !== null) {
                    item.children.push(var_local);
                }
                let var_input = this.getVar('VAR_INPUT', m[0], doc, 'Input variables');
                if (var_input !== null) {
                    item.children.push(var_input);
                }
                let var_output = this.getVar('VAR_OUTPUT', m[0], doc, 'Output variables');
                if (var_output !== null) {
                    item.children.push(var_output);
                }
                let var_in_out = this.getVar('VAR_IN_OUT', m[0], doc, 'Through variables');
                if (var_in_out !== null) {
                    item.children.push(var_in_out);
                }
                
                symbols.push(item);
            }
                
            resolve(symbols);
        });
    }
            
    private getVar(vars:string, scope: string, doc: string, description: string): vscode.DocumentSymbol | null {
        let symbols: vscode.DocumentSymbol[] = [];
        let regex = new RegExp(vars + "\\b([\\s\\S]*?)end_var\\b","img");
        let m = scope.match(regex);
        if (m !== null) {
            let lines = m[0].split('\n');
            lines.forEach(line => {
                let variables = line.match(/\b([a-zA-Z0-9_]*)\b\s*(.*)?\s*:\s*\b([a-zA-Z0-9_]*)\b([\s\S]*);\s*(\(\*(.*)\*\))?/);
                if(variables !== null) {
                    let range = this.getRange(doc, variables[0]);
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

            if(symbols.length > 0 ) {
                let range = this.getRange(doc, m[0]);
                let child = new vscode.DocumentSymbol(vars, description, vscode.SymbolKind.Constructor, range, range);
                child.children = symbols;
                return child;
            }
    
        }
      
        return null;
    }

    private getLineNum(text: string, substring: string) : number {
        var index = text.indexOf(substring);
        var tempString = text.substring(0, index);
        return tempString.split('\n').length - 1;
    }
    private getRange(doc: string, match: string): vscode.Range {
        let pos1 = new vscode.Position(this.getLineNum(doc, match), doc.indexOf(match));
        let pos2 = new vscode.Position(this.getLineNum(doc, match), doc.indexOf(match) + match.length);
        return new vscode.Range(pos1, pos2);
    }
    private dp() {
        return new vscode.Range(
            new vscode.Position(1,2), 
            new vscode.Position(1,2)
        );
    }
}