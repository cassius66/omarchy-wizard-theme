# 0008. VSCodium panes by tone, not lines

- Status: Accepted
- Date: 2026-10-10

## Context

0007 drew every VSCodium border in `muted`, 3.75 to 1 on the background. The
panes became easy to tell apart, but the result looked like a high contrast
theme.

VS Code's own Dark Modern separates panes mostly by tone: the editor is one
step lighter than the side bar, tabs and status bar, and its borders are only
slightly lighter than the surface they sit on.

## Decision

`tools/vscode.sh` uses three tones, all mixed from `colors.toml`:

- chrome: title bar, activity bar, side bar, tab bar, panel and status bar
  are `background`, `#10141b`
- editor: the editor and its active tab are `background` mixed 50 percent
  towards `lighter_background`, `#151a22`
- line: borders are `background` mixed 18 percent towards `muted`, `#1f252f`

The active tab and the active activity bar item keep an `accent` mark. This
supersedes the border colour and chrome colour in 0007. The `muted` and
`dark_foreground` values in 0007 stand.

## Consequences

The editor reads as a lighter pane set into darker chrome, with no bright
lines. The editor background no longer matches the terminal background.
