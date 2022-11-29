import { LangiumDocument, MaybePromise, DefaultDocumentSymbolProvider, NameProvider, LangiumServices, AstNode } from 'langium';
import { CancellationToken, DocumentSymbol, DocumentSymbolParams, SymbolKind } from 'vscode-languageserver';


export class StDocumentSymbolProvider extends DefaultDocumentSymbolProvider {

    protected kinds = {
        'Namespace': SymbolKind.Namespace,
        'Function': SymbolKind.Function,
        'FunctionBlock': SymbolKind.Class,
        'Interface': SymbolKind.Interface,
        'Program': SymbolKind.Class,
        'Var': SymbolKind.Namespace,
        'Method': SymbolKind.Method,
        'VarOutput': SymbolKind.Class
    };


    constructor(services: LangiumServices) {
        super(services);
    }

    getSymbols(document: LangiumDocument): MaybePromise<DocumentSymbol[]> {
        return this.getSymbol(document, document.parseResult.value);
    }

    protected getSymbol(document: LangiumDocument, astNode: AstNode): DocumentSymbol[] {
        type ObjectKey = keyof typeof this.kinds;        const node = astNode.$cstNode;
        const type = <ObjectKey>astNode.$type;
        const nameNode = this.nameProvider.getNameNode(astNode);
        if (nameNode && node) {
            const name = this.nameProvider.getName(astNode);
            return [{
                kind: (this.kinds[type] === undefined ? SymbolKind.Namespace : this.kinds[type]),
                name: name ?? nameNode.text,
                range: node.range,
                selectionRange: nameNode.range,
                children: this.getChildSymbols(document, astNode)
            }];
        } else {
            return this.getChildSymbols(document, astNode) || [];
        }
    }
}
