/******************************************************************************
 * Copyright 2021 TypeFox GmbH
 * This program and the accompanying materials are made available under the
 * terms of the MIT License, which is available in the project root.
 ******************************************************************************/

import { CancellationToken, DocumentSymbol, DocumentSymbolParams, SymbolKind } from 'vscode-languageserver';
import { LangiumDocument, MaybePromise } from 'langium';

/**
 * Language-specific service for handling document symbols requests.
 */
export interface StDocumentSymbolProvider {
    /**
     * Handle a document symbols request.
     *
     * @throws `OperationCancelled` if cancellation is detected during execution
     * @throws `ResponseError` if an error is detected that should be sent as response to the client
     */
    getSymbols(document: LangiumDocument, params: DocumentSymbolParams, cancelToken?: CancellationToken): MaybePromise<DocumentSymbol[]>;
}

export class StDefaultDocumentSymbolProvider implements StDocumentSymbolProvider {
    getSymbols(document: LangiumDocument, params: DocumentSymbolParams, cancelToken?: CancellationToken): MaybePromise<DocumentSymbol[]> {
        return new Promise((resolve) => {resolve(document);} );
    }
}
