import { Cancellation, DefaultScopeComputation } from 'langium';
import type { AstNodeDescription, LangiumCoreServices, LangiumDocument, LocalSymbols } from 'langium';

/**
 * Custom scope computation for IEC 61131-3 Structured Text.
 * Handles cross-file references for global variables, types, and POUs.
 */
export class StScopeComputation extends DefaultScopeComputation {
    constructor(services: LangiumCoreServices) {
        super(services);
    }

    /**
     * Phase 6e: Override to export global variables, types, and POU names
     * to the global scope for cross-file reference resolution.
     */
    override async collectExportedSymbols(
        document: LangiumDocument,
        cancelToken = Cancellation.CancellationToken.None
    ): Promise<AstNodeDescription[]> {
        return super.collectExportedSymbols(document, cancelToken);
    }

    /**
     * Phase 6e: Override to compute local scopes within POUs
     * (VAR block variables visible to the POU body, etc.).
     */
    override async collectLocalSymbols(
        document: LangiumDocument,
        cancelToken = Cancellation.CancellationToken.None
    ): Promise<LocalSymbols> {
        return super.collectLocalSymbols(document, cancelToken);
    }
}
