## Verification

Run both checks to confirm the code is correct:

```bash
npm run compile && npm run lint
```

- `compile` — TypeScript type-check (`tsc -p ./`). Must pass with zero errors.
- `lint` — ESLint (`eslint src --ext ts`). Must pass with zero warnings/errors.
- If either fails, fix the issues before proceeding.
- Full test suite (`npm test`) requires VS Code Electron runtime; at minimum compilation + lint must pass.

## Changelog

Always append new entries under the `[Unreleased]` heading in `CHANGELOG.md`.
Never add entries under a version tag heading (e.g., `[1.5.0]`).

- If the `## [Unreleased] MM/DD/YYYY` heading does not exist at the top of
  the file, create it with today's date.
- Format: `- <tag>: <description> (#<PR number>)`
- Allowed tags: `fix`, `feat`, `enhance`, `docs`, `add`, `change`
- Update the `[Unreleased]` heading date to today in `MM/DD/YYYY` format
  (e.g., `## [Unreleased] 07/05/2026`).
- Do not create a new version heading (e.g., `[1.4.1]`).
- Do not change the version in `package.json`.
- Version bumps and release tag creation are handled by separate automation.
  Entries must remain under `[Unreleased]` until then.

## README

If the change introduces a new setting, behavior, or user-facing difference,
document it in the relevant section of `README.md`.

## Localization

Whenever user-facing text is added or changed:

- **Source code:** wrap all user-visible strings in `vscode.l10n.t()`. Use
  `{0}`, `{1}` placeholders for variables; never string concatenation.
- **Regenerate base bundle:** run `npx @vscode/l10n-dev export -o l10n src`.
- **Update all 6 language bundles** with translations for new or changed keys:
  - `l10n/bundle.l10n.ru.json` (Russian)
  - `l10n/bundle.l10n.zh-cn.json` (Chinese Simplified)
  - `l10n/bundle.l10n.ja.json` (Japanese)
  - `l10n/bundle.l10n.de.json` (German)
  - `l10n/bundle.l10n.fr.json` (French)
  - `l10n/bundle.l10n.es.json` (Spanish)
- **If the change is in `package.json`** (command titles, category, view
  names, config descriptions), update `package.nls.json` and all
  `package.nls.{locale}.json` files.
- Technical Git Flow terms (Feature, Bugfix, Hotfix, Release, Support) may
  stay untranslated where community convention prefers English.

## Commit summary

After every change, output a short commit-message summary to the user.

- Describe what changed and why — one to three lines.
- Format it as a ready-to-use commit message.
- Display it prominently so the user can copy-paste.
- Never commit changes — the user commits manually.

## GitHub CLI

Use `gh` CLI for all GitHub interactions (issues, pull requests, labels,
milestones). Never use web APIs or browser-based workflows for GitHub
operations.

When an issue is fixed, a PR is merged, or an investigation completes:

- **Add a comment** on the issue with the resolution or findings.
- **If fixed**, close the issue with `gh issue close <number>` and include
  the fix summary in the closing comment.
- **If a PR fixes an issue**, link them with `gh pr edit <number> --body`
  or use `Fixes #<number>` in the PR description so GitHub auto-closes on
  merge.

## Plans directory

When the user asks to create a plan or design document, save it in `plans/`.

## Project SYSTEM.md

When project-level configuration changes (TypeScript version, build tooling,
project conventions), update `.pi/SYSTEM.md`.
