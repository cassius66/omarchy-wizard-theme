#!/bin/bash
#
# Regenerate vscode-theme.json from colors.toml.
#
# Omarchy builds VS Code and VSCodium colours from its own template, which
# paints the side bar, tabs, panel and editor one colour with borders in the
# background colour. On this palette that leaves no visible edge between them.
# This script runs Omarchy's own generator on colors.toml, then darkens the
# chrome around the editor and draws its borders in muted. A theme that ships
# vscode-theme.json is used as is, so rerun this after changing colors.toml
# or after an Omarchy update changes the template.
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

jq --indent 4 \
  --arg chrome "$(color dark_background)" \
  --arg border "$(color muted)" \
  --arg accent "$(color accent)" '
  .colors += {
    "titleBar.activeBackground": $chrome,
    "titleBar.inactiveBackground": $chrome,
    "titleBar.border": $border,
    "activityBar.background": $chrome,
    "activityBar.border": $border,
    "sideBar.background": $chrome,
    "sideBar.border": $border,
    "sideBarSectionHeader.background": $chrome,
    "sideBarSectionHeader.border": $border,
    "editorGroupHeader.tabsBackground": $chrome,
    "editorGroupHeader.noTabsBackground": $chrome,
    "editorGroupHeader.tabsBorder": $border,
    "editorGroup.border": $border,
    "tab.inactiveBackground": $chrome,
    "tab.border": $border,
    "tab.activeBorder": $accent,
    "tab.activeBorderTop": $accent,
    "panel.background": $chrome,
    "panel.border": $border,
    "panelSection.border": $border,
    "panelSectionHeader.background": $chrome,
    "panelSectionHeader.border": $border,
    "terminal.background": $chrome,
    "terminal.border": $border,
    "statusBar.background": $chrome,
    "statusBar.noFolderBackground": $chrome,
    "statusBar.border": $border
  }' "$scratch/.local/state/omarchy/current/next-theme/vscode-theme.json" >vscode-theme.json

echo "Wrote vscode-theme.json"
