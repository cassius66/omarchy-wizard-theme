# 0007. Higher contrast for borders and dim text

- Status: Accepted
- Date: 2026-10-10

## Context

In VSCodium, borders and dim text were hard to see. `muted` was `#3b4556`, a
contrast ratio of 1.9 to 1 on `background`. Omarchy's VS Code template uses
`muted` 131 times: borders, comments, line numbers, inactive tabs. Of the 22
stock themes, Ethereal and Vantablack put `muted` near 4.9 to 1.

The template also paints the side bar, tabs, panel, status bar and editor in
`background`, with several borders in `background` too. No value in
`colors.toml` can make those edges visible.

A theme that ships `vscode-theme.json` is used in place of the generated one.
`vscode.json` is refused for themes installed from git; `vscode-theme.json` is
not.

## Decision

`muted` is `#64718a`, 3.75 to 1, and `dark_foreground` is `#7a8599`, 5.0 to
1. Hue stays the same.

`tools/vscode.sh` runs Omarchy's own generator on `colors.toml`, then sets the
title bar, activity bar, side bar, tab bar, panel and status bar to
`dark_background` and their borders to `muted`. The result is committed as
`vscode-theme.json`. Colours still come only from `colors.toml`, as 0002
requires.

## Consequences

The editor reads as a lighter pane framed by darker chrome, with a 1 pixel
line at each edge. Comments and line numbers are readable.

`vscode-theme.json` does not follow Omarchy template changes on its own.
`tools/vscode.sh` has to be rerun after an Omarchy update that changes the
template, and after any change to `colors.toml`.

Open VSCodium windows keep the old colours until they are reloaded.
