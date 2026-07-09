# VS Code Extension — Structured Text (IEC 61131-3)

VS Code language support extension for IEC 61131-3 Structured Text.
Publisher: Serhioromano, version 1.13.2.
Repository: https://github.com/Serhioromano/vscode-st

## Project layout

```
src/extension.ts        # Entry point — activate()/deactivate()
src/formatter.ts        # STFormatterProvider — regex-based formatting
src/symbolprovider.ts   # STDocumentSymbolProvider — regex-based outline/symbols
syntaxes/st.tmLanguage.json   # TextMate grammar (syntax highlighting)
syntaxes/md.codeblock.json    # Injected grammar for Markdown ```iecst blocks
syntaxes/xml.codeblock.json   # Injected grammar for XML <ST>/<Declaration> blocks
language-configuration.json   # Brackets, auto-close, folding, word pattern
snippets/st.snippets.json     # 38 snippets, prefix "st "
ST.g4                         # ANTLR4 formal grammar (not used at runtime)
```

## Tech stack

- **Language**: TypeScript, strict mode, ES2020 target, CommonJS modules
- **Build**: esbuild bundles `src/extension.ts` → `out/extension.js`
- **Lint**: ESLint with @typescript-eslint parser
- **Format**: Prettier (printWidth 110, tabWidth 4, singleQuote false, trailingComma es5)
- **EditorConfig**: 4-space indent, LF, utf-8, trim trailing whitespace
- **VS Code engine**: ^1.36.0
- **Testing**: Mocha, @vscode/test-electron

## Dependencies

**Runtime** (in `dependencies`):
- `vscode-languageclient` ^9.0.1 — LSP client (not yet connected)
- `vscode-languageserver` ^9.0.1 — LSP server (not yet implemented)

**Dev**:
- `chevrotain` ^12.0.0 — parser toolkit (available for LSP work)
- `esbuild` ^0.28.0, `typescript` ^6.0.3, `mocha` ^11.7.5, `vsce` ^2.15.0

## Current features

1. **Syntax highlighting** via TextMate grammar for 15 file extensions: .st, .iecst, .scl, .exp, .vpl, .iecplc, .TcDUT, .TcPOU, .TcGVL, .iecstl, and injected grammars for Markdown and XML
2. **Snippets** — 38 snippets covering PROGRAM, FUNCTION, FUNCTION_BLOCK, IF/ELSIF/ELSE, CASE, FOR, WHILE, REPEAT, VAR blocks, TYPE (enum/struct/union), METHOD, PROPERTY, CLASS, ACTION, TRY/CATCH, __NEW/__DELETE
3. **Outline / Document Symbols** — custom `STDocumentSymbolProvider` using complex regex to parse POU blocks (PROGRAM, FUNCTION, FUNCTION_BLOCK, CLASS, INTERFACE, METHOD, PROPERTY, ACTION), VAR blocks, TYPE declarations (struct, union, enum)
4. **Breadcrumbs / Go to Symbol** — built on the symbol provider
5. **Formatting** (beta) — `STFormatterProvider` applies regex-based keyword capitalization and spacing rules
6. **Bracket matching, auto-close, folding** — via `language-configuration.json`, includes off-side folding and `//#region` markers

## Roadmap / planned

- LSP (Language Server Protocol) implementation — `feature/lsp` branch exists
- Code suggestions / completions
- Lint / diagnostics

## How features work

### Syntax highlighting
Pure TextMate grammar in `syntaxes/st.tmLanguage.json`. No parser involved. Keywords, types, functions, operators, comments, strings — all regex-based tokenization. Injected grammars for Markdown and XML add `iecst` code block support.

### Document symbols (outline)
`src/symbolprovider.ts` — the most complex module. Parses ST source with a single-pass regex engine that skips strings and comments. Identifies:
- POU blocks (PROGRAM, FUNCTION, FUNCTION_BLOCK, CLASS, INTERFACE, METHOD, PROPERTY, ACTION) — returned as `DocumentSymbol` with proper `SymbolKind`
- VAR blocks (VAR, VAR_INPUT, VAR_OUTPUT, VAR_IN_OUT, VAR_TEMP, VAR_GLOBAL, VAR_ACCESS, VAR_EXTERNAL, VAR_CONFIG) — as `SymbolKind.File` containers with variable children
- TYPE declarations — STRUCT, UNION, ENUM — parsed recursively with member items
- Variable declarations inside any block — comma-separated lists, AT addresses, initial values

The regex logic is described in a comment block at the top of the file. It uses a skip-over-strings-and-comments pattern and then matches POU boundaries with nesting-aware lookaheads.

### Formatting
`src/formatter.ts` — two-pass regex approach:
1. **Spacing**: removes double spaces, adjusts spacing around operators (`:=`, `<>`, `>=`, `<=`, `=>`, `+`, `-`, `/`, `<`, `>`, `=`), before/after comments, and fixes `IF(` → `IF (` and `)THEN` → `) THEN`. Skips strings and comments.
2. **Capitalization**: uppercases all known keywords, types, function names, and END_* blocks. Recognizes types (INT, DINT, BOOL, REAL, STRING, TIME, etc.), keywords (TRUE, FALSE, EXIT, CONTINUE, RETURN, etc.), and POU block names (PROGRAM, FUNCTION, IF, CASE, etc.). Also recognizes `*_TO_*` type-cast patterns.

### Snippets
`snippets/st.snippets.json` — all prefixed with `st ` keyword. Uses choice-placeholders (e.g., `${2|BOOL,BYTE,WORD,...|}`) for type selection.

## Development

### Debug

- `F5` → "Run Extension" launch config, opens Extension Development Host with `--profile=ExtensionDebug`
- Pre-launch task runs default build task

### Branch strategy

- `master` — stable releases
- `develop` — active development

## Non-obvious details

- Runtime LSP dependencies (langium, vscode-languageclient, vscode-languageserver) are declared in `package.json` but no LSP server or client is initialized in `extension.ts`. These are groundwork for the planned LSP feature.
- The symbol provider parses the entire document as a single string, not incrementally. `CancellationToken` is accepted but not checked during parsing.
- The formatter also operates on the entire document text and replaces it in one `TextEdit`.
- Variable declarations with comma-separated names (`a, b, c : INT;`) are properly handled in symbols — each gets its own `DocumentSymbol`.
