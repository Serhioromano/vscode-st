import { startLanguageServer } from 'langium/lsp';
import { NodeFileSystem } from 'langium/node';
import { createConnection, ProposedFeatures } from 'vscode-languageserver/node';
import { createStServices } from './st-module.js';

const connection = createConnection(ProposedFeatures.all);
const { shared } = createStServices({ connection, ...NodeFileSystem });
startLanguageServer(shared);
