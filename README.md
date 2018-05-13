# Structured Text (IEC 61131-3)

Most complete Structured Text language support.

## Syntax Highlights

Includes syntax highlight based on IEC 61131-3 draft, including namespaces, SFC elements (STEP, ACTION, TRANSITION), constant variables (2#000_1010, 16#1E, INT#23) and more.

![Structured Text syntax highlights example](https://raw.githubusercontent.com/Serhioromano/vscode-st/master/example.png)

## Snippets

Fast growing snippets library. All cycles, conditions and declarations.

## Commands

Can automatically capitalize constants like `TRUE`, `FALSE`. Either use command `ST: Format` from command pallet, of from editor context menu. There is also user setting `st.autoFormat` which is set `true` by default, you can turn it off.

## Note

- The same Author contributed ST support for Monaco Editor and highlight.js.
- This extension project is a part of my "Structured Text Bible" book which I am working on right now.

## Roadmap

- LSP (Language Server Protocol)
- Suggestions
- Lints

## Release Notes

### 1.2.0

Big step forward. Now it is not only language configuration it is JS code that can enhance codding experience.

- add - Command pallet `Ctrl+Shift+P` command `ST: Format`
- add - same command context menu
- add - user parameter `st.autoFormat`

All 3 make the same. Capitalize constants like `TRUE`, `FALSE`, `EXIT` and others. Right now only few. This is only proof of concept. Later we will add more beautifications.

### 1.1.0

- add - a lot of different snippets
- enhance - syntax highlight like function names, program and function definitions, etc..

### 1.0.9

- fix - extensions metadata tags
- add - new functions to support logi.CAD 3 reference variables.
- enhance - auto indentations inside IF, PROGRAM, VAR, ...

### 1.0.8

- fix - close `[` bracket
- add - region folding
- improve - keywords case

### 1.0.7

- improve - readme file
- improve - syntax highlights scopes

### 1.0.5

- add- few new snippets.
- fix - some keywords highlight issue

### 1.0.4

- add- new file extensions to support logi.CAD 3 projects.