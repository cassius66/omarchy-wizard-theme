# 0001. Icons come from Papirus-Pixel, installed per user

- Status: Accepted
- Date: 2026-10-10

## Context

An Omarchy theme names its icon theme in `icons.theme`. It cannot install
one: `omarchy theme install` clones the repo and applies it, and a theme
installed that way may not ship code. The icons this theme wants,
Papirus-Pixel, are built in the fork `cassius66/papirus-pixel`.

The Super+Space launcher in Omarchy 4.0 does not use the selected icon theme
for app icons. On every open it lists every icon file under `~/.icons`,
`~/.local/share/icons` and `/usr/share/icons`, in that order, and keeps the
first file found for each name. Installing Papirus-Pixel next to other themes
in `/usr/share/icons` gave a launcher of icons mixed from several themes.

## Decision

`icons.theme` names `Papirus-Pixel`. The README tells the user to install it
from the fork's release into `~/.local/share/icons`, and to install
`papirus-icon-theme` from Arch, which Papirus-Pixel inherits from. The theme
repo ships no icons and no installer.

## Consequences

Without the icons installed the theme still applies. GTK falls back to its
default icons and nothing breaks.

Papirus-Pixel in `~/.local/share/icons` wins in the launcher for every
Omarchy theme, not only this one, because the launcher scans that folder
first. Removing the folder is the only way back.

Icon updates follow the fork's releases, not this repo.
