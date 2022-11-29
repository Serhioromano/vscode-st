import { Declarations } from './generated/ast';
import { LangiumDocument, MaybePromise, DefaultDocumentSymbolProvider, NameProvider, LangiumServices, AstNode } from 'langium';
import { CancellationToken, DocumentSymbol, DocumentSymbolParams, SymbolKind, SymbolTag } from 'vscode-languageserver';
import { Range } from 'vscode';

type KindsList = { [k: string]: SymbolKind };
type KindsListKey = keyof KindsList;

export class StDocumentSymbolProvider extends DefaultDocumentSymbolProvider {

    protected kinds: KindsList = {
        'Namespace': SymbolKind.Namespace,
        'Function': SymbolKind.Function,
        'FunctionBlock': SymbolKind.Class,
        'Interface': SymbolKind.Interface,
        'Program': SymbolKind.Class,
        'Var': SymbolKind.Namespace,
        'Methods': SymbolKind.Method,
        'DataTypesAlias': SymbolKind.Field,
        'DataTypesStruct': SymbolKind.Struct,
        'DataTypesEnum': SymbolKind.Enum,
        'VarOutput': SymbolKind.Class,
    };


    constructor(services: LangiumServices) {
        super(services);
    }

    getSymbols(document: LangiumDocument): MaybePromise<DocumentSymbol[]> {
        return this.getSymbol(document, document.parseResult.value);
    }

    protected getSymbol(document: LangiumDocument, astNode: AstNode): DocumentSymbol[] {
        const node = astNode.$cstNode;
        const nameNode = this.nameProvider.getNameNode(astNode);

        if (astNode.hasOwnProperty("declarations")) {
            let decl : Declarations[] = (astNode as any)["declarations"];
            if (decl.length === 0) {
                return [];
            }

            let list: DocumentSymbol[] = [];
            const isConst = decl[0]?.dec_constant.includes("CONSTANT");
            decl.forEach((el: Declarations) => {
                list.push({
                    kind: isConst ? SymbolKind.Constant : SymbolKind.Variable,
                    name: el.variable_name,
                    range: <Range>el.$cstNode?.range,
                    selectionRange: <Range>el.$cstNode?.range
                });
            });
            return [{
                kind: SymbolKind.File,
                name: <string>(astNode.$type === 'VarLocal' ? "VAR" : astNode.$type.replace("Var", "var_").toUpperCase()),
                range: <Range>node?.range,
                selectionRange: <Range>node?.range,
                children: list
            }];
        }
        if (nameNode && node) {
            const name = this.nameProvider.getName(astNode);
            return [{
                kind: this.SymbolKind(astNode),
                name: name ?? nameNode.text,
                range: node.range,
                selectionRange: nameNode.range,
                children: this.getChildSymbols(document, astNode),
                detail: astNode.$type
            }];
        } else {
            return this.getChildSymbols(document, astNode) || [];
        }
    }

    protected SymbolKind(astNode: AstNode): SymbolKind {
        let index: KindsListKey = astNode.$type;
        if (astNode.$type === 'DataType') {
            if (astNode.hasOwnProperty("types_enum")) {
                index = "DataTypesEnum";
            } else if (astNode.hasOwnProperty("types_struct") || astNode.hasOwnProperty("types_union")) {
                index = "DataTypesStruct";
            } else if (astNode.hasOwnProperty("types_alias")) {
                index = "DataTypesAlias";
            }
        }

        return (this.kinds[index] === undefined ? SymbolKind.Field : this.kinds[index]);
    }
}
