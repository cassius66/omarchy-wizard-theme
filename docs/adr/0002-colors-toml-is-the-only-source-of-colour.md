# 0002. colors.toml is the only source of colour

- Status: Accepted
- Date: 2026-10-10

## Context

Omarchy generates the terminal, editor, bar, Hyprland and btop configs of a
theme from its `colors.toml`. A theme installed from git may not ship Lua,
terminal configs or `vscode.json`; Omarchy drops them and generates its own.
The wallpaper, `unlock.png` and `preview-unlock.png` are images, which
Omarchy does not generate.

The images use Omarchy's pixel wordmark. Every stock theme ships it as a two
colour `omarchy.png` and a one colour `unlock.png`.

## Decision

Every colour lives in `colors.toml`. The theme ships no per-app config.
`tools/images.sh` repaints Omarchy's wordmark images with `background`,
`accent`, `foreground` and `lighter_background`, and its output is committed.

## Consequences

Changing a colour is one edit plus one script run.

Per-app tuning beyond what Omarchy's templates derive is not possible without
breaking this rule. A later record has to overturn this one first.

`tools/images.sh` needs ImageMagick and an installed Omarchy for its source
images. Omarchy is MIT, so its license travels with the derived images in
`docs/omarchy-license.txt`.
