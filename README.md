# Structured Text (IEC 61131-3)

Most complete Structured Text language support. Features includes:

- Syntax highlights
- Snippets
- Outline view
- Breadcrumbs
- Go to Symbol in File
- Commands

## Syntax Highlights

Includes syntax highlight based on IEC 61131-3 draft, including namespaces, SFC elements (STEP, ACTION, TRANSITION), constant variables (2#000_1010, 16#1E, INT#23) and more.

![Structured Text syntax highlights example](https://raw.githubusercontent.com/Serhioromano/vscode-st/master/demo.gif)

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

### 1.5.0

- improve - function highlights. Now we Highlight all function either user defined or built in.
- improve - variable declaration or `STRUCT` declaration section has got a lot of improvements. We highlight custom types now, and whole section looks much cleaner because scopes were changed.
- improve - If you call for a method of a function block through dot `my_fb.method()` method is highlighted. We also highlight function block properties or parameters.
- add - TODO or TODO: in comments attract an attention
- add - Highlights for action modifiers `myAction(DS, T#3s);` where DS will be highlighted.
- add - Highlights for names of parameters of function block.
- 
### 1.4.0

I've learned few things about syntax highlights. Big refactoring. I added some missing keywords, changed some coloring scopes and improved coloring in general.

### 1.3.1

- add - TYPE creation snippets (enumerations ans structure) and enhance it's syntax highlights
- enhance - Select type out of suggestion list when inset variable in declaration area from snippet
- enhance - Utilise [October 2018](https://code.visualstudio.com/updates/v1_28#_project-level-snippets) feature for multiple prefixes in snippets and add multiple prefixes to some snippets.
- fix - syntax highlights for function_block

### 1.3.0

More stable version

- fix - Auto close comments `/*`. `(*`.
- enhance - revision of highlights much better now.

### 1.2.4

- fix - Insert `END_VAR` after `VAR` is inserted.
- fix - highlights for `WORD` datatype.
- fix - other minor changes

### 1.2.3

- fix - Notification "This file not a structured text language!" #6

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