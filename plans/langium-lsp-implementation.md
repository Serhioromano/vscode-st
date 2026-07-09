# Plan: LSP Implementation with Langium

**Date:** 2026-07-09
**Status:** Phase 1 complete, Phase 2+ pending
**Branch:** `feature/lsp`

**Phase 1 files:** `examples/*.st` (15 files, 991 lines)

## 1. Summary

Integrate a full Language Server Protocol (LSP) implementation into the
vscode-st extension using the [Langium](https://langium.org) framework
(v4.x). Langium is a TypeScript-based language engineering tool that
generates a parser, AST types, and LSP infrastructure from a declarative
grammar. The existing ANTLR4 grammar (`ST.g4`) serves as the reference
for the Langium grammar.

The LSP integration replaces all regex-based features (symbol provider,
formatter) with Langium-based counterparts. Syntax highlighting via
TextMate grammar and snippets remain as complementary features.

## 2. Current State

| Component                   | Implementation                     | Status     |
|-----------------------------|------------------------------------|------------|
| Syntax highlighting         | TextMate grammar (`st.tmLanguage`) | Production |
| Document symbols / outline  | Regex-based `STDocumentSymbolProvider` | Production |
| Formatting                  | Regex-based `STFormatterProvider`  | Beta       |
| Snippets                    | `st.snippets.json`                 | Production |
| LSP client/server deps      | In `package.json`, not wired       | Placeholder |
| ANTLR4 grammar              | `ST.g4` — comprehensive            | Reference only |

## 3. Target Architecture

```
┌──────────────────────────────────────────┐
│  VS Code Extension (extension.ts)        │
│  - activate():                           │
│    • start Langium language server       │
│    • register TextMate grammar           │
│    • register snippets (keep)            │
└──────────────┬───────────────────────────┘
               │ LSP (stdio / IPC)
┌──────────────▼───────────────────────────┐
│  Language Server (src/lsp/main.ts)       │
│  - createConnection()                    │
│  - createStServices()                    │
│  - startLanguageServer(shared)           │
└──────────────┬───────────────────────────┘
               │
┌──────────────▼───────────────────────────┐
│  Langium Services (DI container)         │
│  ┌─────────────────────────────────┐     │
│  │ st.langium  ← grammar definition │     │
│  └──────────────┬──────────────────┘     │
│                 │ langium generate       │
│  ┌──────────────▼──────────────────┐     │
│  │ src/generated/                   │     │
│  │  • ast.ts     (AST types)        │     │
│  │  • grammar.ts (grammar accessor) │     │
│  │  • module.ts  (DI modules)       │     │
│  └─────────────────────────────────┘     │
│                                          │
│  Custom services:                        │
│  • StValidator      — semantic checks   │
│  • StFormatter      — AST formatting    │
│  • StScopeProvider  — cross-refs scope  │
│  • StCompletionProvider — code complete │
└──────────────────────────────────────────┘
```

## 4. Implementation Phases

### Phase 1 — Example Files (Week 1)

Before any grammar work, create a comprehensive set of example ST files
in an `examples/` folder. These files must represent every syntactic
form the language must support. This set is the acceptance criteria for
the grammar and LSP features.

**Required coverage per file (one aspect per file, combined where
natural):**

- `01-program.st` — Simple PROGRAM with VAR, statements (IF, assign),
  END_PROGRAM
- `02-function.st` — FUNCTION with return type, VAR_INPUT, function
  body
- `03-function-block.st` — FUNCTION_BLOCK with VAR_INPUT, VAR_OUTPUT,
  VAR, internal state logic
- `04-namespace.st` — NAMESPACE containing multiple PROGRAMs and
  FUNCTION_BLOCKs
- `05-types.st` — TYPE declarations: STRUCT, ENUM, UNION, alias (ARRAY
  of INT, etc.)
- `06-class.st` — CLASS with METHOD, PROPERTY, VAR, access modifiers
- `07-interface.st` — INTERFACE with METHOD signatures,
  IMPLEMENTS
- `08-expressions.st` — All operators: arithmetic, comparison, logical,
  function calls, parenthesized expressions, IEC addresses (%IX0.0)
- `09-control-flow.st` — IF/ELSIF/ELSE, CASE, FOR (with BY), WHILE,
  REPEAT, EXIT, CONTINUE, RETURN
- `10-var-blocks.st` — All VAR variants: VAR_INPUT, VAR_OUTPUT,
  VAR_IN_OUT, VAR_TEMP, VAR_STAT, VAR_GLOBAL, VAR_ACCESS, VAR_EXTERNAL,
  VAR_CONFIG; RETAIN, PERSISTENT, CONSTANT qualifiers; AT addresses
- `11-action.st` — ACTION inside PROGRAM and FUNCTION_BLOCK
- `12-strings-comments.st` — Single/double-quoted strings, // comments,
  (* *) comments, nested comments
- `13-data-types.st` — All standard types: INT variants, REAL variants,
  STRING/WSTRING, TIME variants, BYTE/WORD/DWORD/LWORD, arrays
- `14-try-catch.st` — __TRY, __CATCH, __FINALLY, __ENDTRY
- `15-multi-file` — Multiple `.st` files with cross-file references
  (global variables, type references)

> **Gate:** These example files must be reviewed and confirmed before
> proceeding to Phase 2. They define the contract for the grammar.

### Phase 2 — Grammar Translation (Week 2-3)

Translate the ANTLR4 grammar (`ST.g4`) into a Langium `.langium` grammar
file, driven by the example files from Phase 1. Every construct in the
examples must parse successfully.

**Key differences ANTLR4 → Langium:**

| ANTLR4                    | Langium                          |
|---------------------------|----------------------------------|
| `grammar ST;`             | `grammar St`                     |
| Lexer rules (uppercase)   | `terminal` rules                 |
| Parser rules (lowercase)  | Parser rules (PascalCase)        |
| `-> skip` channel         | `hidden terminal`                |
| `fragment`                | Not needed — inline regex        |
| Literal strings in rules  | `'KEYWORD'` same syntax          |
| `|` alternatives          | `|` alternatives, same syntax    |
| `*` `+` `?` quantifiers   | Same                             |
| `#label` alternatives     | Not needed — use rule splitting  |

**Grammar categories will be defined during this phase** based on the
Langium DSL's conventions. The initial ANTLR categories (terminals,
parser rules, cross-references) serve as a reference but will be
restructured to fit Langium idioms:

- Terminals: hidden (`WS`, `NEWLINE`, comments) and visible (`ID`,
  `INTEGER`, `FLOAT`, `STRING`, `OPERATOR`, `LA`)
- Parser rules: PascalCase, organized by POU type, declarations,
  statements, expressions with explicit precedence
- Cross-references: `[POU]` brackets for name resolution across
  declarations
- Expressions: explicit operator precedence via rule nesting
  (Addition → Multiplication → Unary → Primary)

**The grammar configuration uses `caseInsensitive: true`** since
IEC 61131-3 keywords are case-insensitive.

### Phase 3 — Build Infrastructure (Week 2-3, parallel with Phase 2)

1. **Create `langium-config.json`** (or use `package.json` config):

```json
{
  "projectName": "vscode-st",
  "languages": [{
    "id": "st",
    "grammar": "src/lsp/st.langium",
    "fileExtensions": [".st", ".iecst", ".scl", ".exp", ".vpl",
                       ".iecplc", ".TcDUT", ".TcPOU", ".TcGVL", ".iecstl"],
    "textMate": {
      "out": "syntaxes/st.tmLanguage.json"
    },
    "caseInsensitive": true
  }],
  "out": "src/lsp/generated"
}
```

> **Note:** The grammar must use `caseInsensitive: true` since IEC 61131-3
> keywords are case-insensitive (`PROGRAM` = `Program` = `program`).

2. **Add npm scripts:**
```json
"langium:generate": "langium generate",
"langium:watch": "langium generate --watch"
```

3. **Restructure source tree:**
```
src/
├── extension.ts          # Existing — updated to start LSP
├── formatter.ts          # Existing regex formatter (keep)
├── symbolprovider.ts     # Existing regex symbols (keep)
└── lsp/
    ├── main.ts           # Language server entry point (NEW)
    ├── st.langium        # Langium grammar (NEW)
    ├── st-module.ts      # DI module with custom services (NEW)
    ├── st-validator.ts   # Semantic validation (NEW)
    ├── st-formatter.ts   # Langium-based formatter (NEW)
    ├── st-scope.ts       # Cross-reference scope (NEW)
    ├── st-completion.ts  # Code completion provider (NEW)
    └── generated/        # Auto-generated by langium-cli
        ├── ast.ts
        ├── grammar.ts
        └── module.ts
```

4. **Update build (esbuild):**

The language server and extension must bundle separately:

```js
// esbuild.mjs
import * as esbuild from 'esbuild';

// Extension bundle
await esbuild.build({
  entryPoints: ['src/extension.ts'],
  bundle: true,
  outfile: 'out/extension.js',
  external: ['vscode'],
  format: 'cjs',
  platform: 'node',
});

// Language server bundle
await esbuild.build({
  entryPoints: ['src/lsp/main.ts'],
  bundle: true,
  outfile: 'out/lsp-server.js',
  external: ['vscode'],
  format: 'cjs',
  platform: 'node',
});
```

### Phase 4 — Test Environment (Week 3)

Before implementing LSP features, create the development and test
infrastructure using the Phase 1 example files as test fixtures.

1. **Launch configuration** — Add a VS Code debug config that starts
   the extension with the language server, opening the `examples/`
   folder as workspace:

   ```json
   // .vscode/launch.json
   {
     "name": "Launch ST Extension + LSP",
     "type": "extensionHost",
     "request": "launch",
     "args": [
       "${workspaceFolder}/examples",
       "--extensionDevelopmentPath=${workspaceFolder}"
     ],
     "outFiles": ["${workspaceFolder}/out/**/*.js"],
     "preLaunchTask": "npm: esbuild"
   }
   ```

2. **Grammar parse tests** — Use `parseHelper` from `langium/test` to
   verify every example file parses without errors:

   ```ts
   // src/lsp/test/grammar.test.ts
   import { createStServices } from '../st-module.js';
   import { parseHelper } from 'langium/test';

   describe('Grammar', () => {
     const services = createStServices(EmptyFileSystem);
     const parse = parseHelper(services.st);

     it('parses 01-program.st', async () => {
       const doc = await parse(readExample('01-program.st'));
       expect(doc.parseResult.lexerErrors).toHaveLength(0);
       expect(doc.parseResult.parserErrors).toHaveLength(0);
     });
     // ... one test per example file
   });
   ```

3. **Smoke test** — Open the example files in the Extension Development
   Host and confirm: no crashes, syntax highlighting works, basic LSP
   initialization succeeds.

### Phase 5 — VS Code Extension Integration (Week 3-4)

**Update `extension.ts`:**

```ts
import * as vscode from 'vscode';
import * as path from 'path';
import {
  LanguageClient,
  LanguageClientOptions,
  ServerOptions,
  TransportKind,
} from 'vscode-languageclient/node';

let client: LanguageClient;

export function activate(context: vscode.ExtensionContext) {
  // --- LSP Client ---
  const serverModule = context.asAbsolutePath(
    path.join('out', 'lsp-server.js')
  );

  const serverOptions: ServerOptions = {
    run: { module: serverModule, transport: TransportKind.ipc },
    debug: {
      module: serverModule,
      transport: TransportKind.ipc,
      options: { execArgv: ['--nolazy', '--inspect=6009'] },
    },
  };

  const clientOptions: LanguageClientOptions = {
    documentSelector: [
      { scheme: 'file', language: 'st' },
    ],
    synchronize: {
      fileEvents: vscode.workspace.createFileSystemWatcher(
        '**/*.{st,iecst,scl,exp,vpl,iecplc,TcDUT,TcPOU,TcGVL,iecstl}'
      ),
    },
  };

  client = new LanguageClient(
    'st-lsp',
    'Structured Text Language Server',
    serverOptions,
    clientOptions
  );

  client.start();

  // --- Existing features ---
  // Snippets remain via package.json contributes.snippets
  // Syntax highlighting remains via TextMate grammar
  // Symbol provider and formatter are replaced by LSP (see Phase 6)
}

export function deactivate() {
  if (client) {
    return client.stop();
  }
}
```

**`src/lsp/main.ts` — Language Server entry:**

```ts
import { startLanguageServer } from 'langium/lsp';
import { NodeFileSystem } from 'langium/node';
import { createConnection, ProposedFeatures } from 'vscode-languageserver/node';
import { createStServices } from './st-module.js';

const connection = createConnection(ProposedFeatures.all);
const { shared } = createStServices({ connection, ...NodeFileSystem });
startLanguageServer(shared);
```

**`src/lsp/st-module.ts` — DI module:**

```ts
import { type Module, inject } from 'langium';
import {
  createDefaultModule,
  createDefaultSharedModule,
  type DefaultSharedModuleContext,
  type LangiumServices,
  type LangiumSharedServices,
  type PartialLangiumServices,
} from 'langium/lsp';
import {
  StGeneratedModule,
  StGeneratedSharedModule,
} from './generated/module.js';
import { StValidator, registerValidationChecks } from './st-validator.js';
import { StFormatter } from './st-formatter.js';
import { StScopeComputation } from './st-scope.js';

export type StAddedServices = {
  validation: {
    StValidator: StValidator;
  };
};

export type StServices = LangiumServices & StAddedServices;

export const StModule: Module<
  StServices,
  PartialLangiumServices & StAddedServices
> = {
  references: {
    ScopeComputation: (services) => new StScopeComputation(services),
  },
  validation: {
    StValidator: () => new StValidator(),
  },
  lsp: {
    Formatter: () => new StFormatter(),
  },
};

export function createStServices(context: DefaultSharedModuleContext): {
  shared: LangiumSharedServices;
  st: StServices;
} {
  const shared = inject(
    createDefaultSharedModule(context),
    StGeneratedSharedModule
  );
  const st = inject(
    createDefaultModule({ shared }),
    StGeneratedModule,
    StModule
  );
  shared.ServiceRegistry.register(st);
  registerValidationChecks(st);
  return { shared, st };
}
```

### Phase 6 — LSP Features (Week 4-6)

#### 6a. Document Symbols (rewrite based on LSP)

Replace the existing regex-based `STDocumentSymbolProvider` with an
AST-aware `DocumentSymbolProvider` powered by Langium's parsed model.
This eliminates the fragile 18 KB regex engine and provides correct
hierarchy for all POU blocks, VAR blocks, TYPE declarations, and nested
structures.

Langium auto-generates basic document symbols from the grammar. For
fine-grained control matching the current outline quality, implement a
custom `DocumentSymbolProvider`:

```ts
// st-module.ts
lsp: {
  DocumentSymbolProvider: (services) =>
    new StDocumentSymbolProvider(services),
}
```

Once this is stable, remove the old `STDocumentSymbolProvider` and its
registration in `extension.ts`.

#### 6b. Semantic Validation (new capability)

Critical IEC 61131-3 checks:
- Duplicate POU names
- Undefined types referenced in VAR declarations
- Type mismatch in assignments and expressions
- Unused variables (warning)
- Use-before-declaration in statement lists
- Missing END_* terminators
- CASE coverage completeness (optional)

#### 6c. Code Completion (new capability)

- Keyword completion (PROGRAM, FUNCTION_BLOCK, IF, CASE, etc.)
- Type completion in VAR declarations
- Variable name completion in expressions
- Function name completion with parameter hints
- Snippet-like completions for block structures

Langium provides `DefaultCompletionProvider` — customize via
`CompletionProvider` service override.

#### 6d. Hover Information (new capability)

- Type information on variable references
- POU signature on function calls
- Documentation comments (if supported)

#### 6e. Go to Definition / Find References (new capability)

Langium provides these out-of-box once cross-references are defined
in the grammar. Custom scope computation for workspace-wide references
(e.g., global variables visible across files).

#### 6f. Formatting (replaces regex formatter)

Replace the existing regex-based `STFormatterProvider` with Langium's
`AbstractFormatter`. Only the LSP formatter will be registered — no
fallback, no config toggle. The regex formatter is removed entirely.

Langium's `AbstractFormatter` provides AST-aware formatting:
- Proper indentation (nested blocks)
- Keyword case normalization
- Spacing around operators
- Formatting is deterministic, not regex-heuristic

#### 6g. Semantic Tokens (new, optional)

Improved syntax highlighting beyond TextMate capabilities:
- Differentiate local vs global variables
- Highlight unresolved references

### Phase 7 — Testing & Polish (Week 6-7)

1. **Validation tests**: Unit tests for each validation rule from
   Phase 6b
2. **Completion tests**: Verify suggestions match expected completions
   for each context
3. **Integration tests**: End-to-end LSP tests using real ST files
   from `examples/`
4. **Performance**: Profile parsing on large ST files (>10K lines)
5. **Parse error resilience**: Verify graceful degradation — syntax
   errors in one section do not break the rest of the document

## 5. Risks & Mitigations

| Risk                                    | Mitigation                                          |
|-----------------------------------------|-----------------------------------------------------|
| IEC 61131-3 is case-insensitive         | Use `caseInsensitive: true` in grammar config       |
| Complex expression precedence           | Carefully model AST hierarchy for operators         |
| IEC addresses (%IX0.0) are unusual      | Dedicate a `terminal LA` rule                       |
| ST keywords overlap with identifiers    | Keyword-as-identifier escape pattern if needed      |
| Large files cause slow parsing          | Use incremental parsing (Langium built-in)          |
| Build complexity (two bundles)          | Single esbuild config with multiple entry points    |
| Migration period: old + new features    | Regex features removed once LSP equivalents ship    |

## 6. Dependencies

Already present in `package.json`:
- `langium` ^4.2.3 (runtime)
- `langium-cli` ^4.2.1 (dev)
- `vscode-languageclient` ^9.0.1
- `vscode-languageserver` ^9.0.1

May need upgrade to v10.x for compatibility with latest Langium v4.x
patterns (the domainmodel example uses `~10.1.0`). Verify compatibility
with the project's `engines.vscode: ^1.36.0` constraint — Langium v4
may require VS Code ≥ 1.82.

## 7. Deliverables

1. **`examples/*.st`** (~15 files) — Comprehensive ST code samples
   covering all language features
2. **`src/lsp/st.langium`** — IEC 61131-3 grammar in Langium DSL
3. **`src/lsp/main.ts`** — Language server entry point
4. **`src/lsp/st-module.ts`** — DI module with custom services
5. **`src/lsp/st-validator.ts`** — Semantic validation rules
6. **`src/lsp/st-formatter.ts`** — AST-aware formatter
7. **`src/lsp/st-scope.ts`** — Cross-reference scope computation
8. **`src/lsp/st-completion.ts`** — Code completion customizations
9. **`src/lsp/st-symbol-provider.ts`** — AST-based document symbol
   provider (replaces regex one)
10. **`src/lsp/test/grammar.test.ts`** — Parse tests for all example files
11. **`src/extension.ts`** — Updated with LSP client startup, old
    providers removed
12. **`esbuild.mjs`** — Dual-bundle build (extension + language server)
13. **`langium-config.json`** — Langium CLI configuration
14. **`.vscode/launch.json`** — Debug config for LSP development

## 8. Migration Path

- **TextMate grammar** — Stays for syntax highlighting. Can optionally
  be regenerated by Langium later.
- **Snippets** — Stay as-is in `st.snippets.json`.
- **Symbol provider** — Removed once LSP-based `DocumentSymbolProvider`
  is stable (Phase 6a).
- **Formatter** — Removed once LSP-based `AbstractFormatter` is stable
  (Phase 6f). No config toggle — only the LSP formatter ships.

**User-visible change:** After Phase 6, document symbols and formatting
are powered by the language server. Users with existing ST files see no
difference in behavior — only improved accuracy and new features
(diagnostics, completion, hover, go-to-definition).
