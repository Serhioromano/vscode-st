import type {
    DocumentFormattingParams,
    DocumentOnTypeFormattingOptions,
    DocumentOnTypeFormattingParams,
    DocumentRangeFormattingParams,
    TextEdit,
} from 'vscode-languageserver-protocol';
import type { Cancellation, LangiumDocument } from 'langium';
import type { Formatter } from 'langium/lsp';

type CancellationToken = Cancellation.CancellationToken;

/**
 * AST-aware formatter for IEC 61131-3 Structured Text.
 * Will replace the regex-based STFormatterProvider in Phase 6f.
 */
export class StFormatter implements Formatter {
    formatDocument(
        _document: LangiumDocument,
        _params: DocumentFormattingParams,
        _cancelToken?: CancellationToken
    ): TextEdit[] {
        // Phase 6f: implement AST-aware formatting
        return [];
    }

    formatDocumentRange(
        _document: LangiumDocument,
        _params: DocumentRangeFormattingParams,
        _cancelToken?: CancellationToken
    ): TextEdit[] {
        // Phase 6f: implement range formatting
        return [];
    }

    formatDocumentOnType(
        _document: LangiumDocument,
        _params: DocumentOnTypeFormattingParams,
        _cancelToken?: CancellationToken
    ): TextEdit[] {
        // Phase 6f: implement on-type formatting
        return [];
    }

    get formatOnTypeOptions(): DocumentOnTypeFormattingOptions | undefined {
        // Phase 6f: return on-type formatting trigger options
        return undefined;
    }
}
