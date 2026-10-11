#!/bin/bash
#
# Regenerate vscode-theme.json from colors.toml.
#
# Omarchy builds VS Code and VSCodium colors from its own template, which
# paints the side bar, tabs, panel and editor one color with borders in the
# background color. On this palette that leaves no visible edge between them.
# This script runs Omarchy's own generator on colors.toml, then lifts the
# editor one tone above the chrome around it and draws faint borders. A theme
# that ships vscode-theme.json is used as is, so rerun this after changing
# colors.toml or after an Omarchy update changes the template.
#
# Requires jq and an installed Omarchy.

set -euo pipefail

cd "$(dirname "$0")/.."
export OMARCHY_PATH="${OMARCHY_PATH:-/usr/share/omarchy}"

color() {
  grep -E "^$1 *=" colors.toml | cut -d'"' -f2
}

# The generator writes into $HOME/.local/state/omarchy/current/next-theme, so
# give it a scratch home with only colors.toml in it.
scratch=$(mktemp -d)
trap 'rm -rf "$scratch"' EXIT
mkdir -p "$scratch/.local/state/omarchy/current/next-theme"
cp colors.toml "$scratch/.local/state/omarchy/current/next-theme/"
HOME="$scratch" "$OMARCHY_PATH/bin/omarchy-theme-set-templates"

# Mix two hex colors, the second at the given fraction.
mix() {
  python3 -c 'import sys; a, b, t = sys.argv[1].lstrip("#"), sys.argv[2].lstrip("#"), float(sys.argv[3]); print("#" + "".join("%02x" % round(int(a[i:i+2], 16) * (1 - t) + int(b[i:i+2], 16) * t) for i in (0, 2, 4)))' "$@"
}

# Three tones, no strong lines. The chrome sits on background, the editor and
# its active tab are lifted towards lighter_background, and borders are a hair
# lighter than the chrome. VS Code's own Dark Modern is built the same way.
BG=$(color background)
EDITOR=$(mix "$BG" "$(color lighter_background)" 0.5)
LINE=$(mix "$BG" "$(color muted)" 0.18)

jq --indent 4 --arg chrome "$BG" --arg editor "$EDITOR" --arg line "$LINE" --arg accent "$(color accent)" '
  .colors += {
    "titleBar.activeBackground": $chrome,
    "titleBar.inactiveBackground": $chrome,
    "titleBar.border": $line,
    "activityBar.background": $chrome,
    "activityBar.border": $line,
    "activityBar.activeBorder": $accent,
    "sideBar.background": $chrome,
    "sideBar.border": $line,
    "sideBarSectionHeader.background": $chrome,
    "sideBarSectionHeader.border": $line,
    "editor.background": $editor,
    "editorGutter.background": $editor,
    "breadcrumb.background": $editor,
    "minimap.background": $editor,
    "editorGroupHeader.tabsBackground": $chrome,
    "editorGroupHeader.noTabsBackground": $chrome,
    "editorGroupHeader.tabsBorder": $line,
    "editorGroup.border": $line,
    "tab.activeBackground": $editor,
    "tab.unfocusedActiveBackground": $editor,
    "tab.inactiveBackground": $chrome,
    "tab.border": $line,
    "tab.activeBorder": $editor,
    "tab.activeBorderTop": $accent,
    "tab.unfocusedActiveBorderTop": $line,
    "panel.background": $chrome,
    "panel.border": $line,
    "panelSection.border": $line,
    "panelSectionHeader.background": $chrome,
    "panelSectionHeader.border": $line,
    "terminal.background": $chrome,
    "terminal.border": $line,
    "statusBar.background": $chrome,
    "statusBar.noFolderBackground": $chrome,
    "statusBar.border": $line
  }' "$scratch/.local/state/omarchy/current/next-theme/vscode-theme.json" >vscode-theme.json

echo "Wrote vscode-theme.json"
