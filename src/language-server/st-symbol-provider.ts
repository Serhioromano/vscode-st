import { LangiumDocument, MaybePromise, DefaultDocumentSymbolProvider, NameProvider, LangiumServices, AstNode } from 'langium';
import { CancellationToken, DocumentSymbol, DocumentSymbolParams, SymbolKind } from 'vscode-languageserver';


export class StDocumentSymbolProvider extends DefaultDocumentSymbolProvider {

    protected readonly nameProvider: NameProvider;
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
        this.nameProvider = services.references.NameProvider;
    }

    getSymbols(document: LangiumDocument): MaybePromise<DocumentSymbol[]> {
        return this.getSymbol(document, document.parseResult.value);
    }

    protected getSymbol(document: LangiumDocument, astNode: AstNode): DocumentSymbol[] {

        const node = astNode.$cstNode;

        const nameNode = this.nameProvider.getNameNode(astNode);
        if (nameNode && node) {
            const name = this.nameProvider.getName(astNode);
            return [{
                kind: SymbolKind.Interface,
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
