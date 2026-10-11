# omarchy-wizard-theme

An Omarchy theme in grays, one blue and a red, with pixel art icons.

## Why

Every color is a gray except one blue for the accent and a red for errors,
with one wallpaper and pixel art icons. The icons are
[papirus-pixel](https://github.com/cassius66/papirus-pixel), a fork of Papirus
drawn on a 24 pixel grid in a 16 color palette.

## Setup

Install the icons first. The theme names them but cannot install them.

```bash
omarchy pkg add papirus-icon-theme
curl -fsSL https://raw.githubusercontent.com/cassius66/papirus-pixel/master/pixel/install.sh | bash
```

Install the theme:

```bash
omarchy theme install https://github.com/cassius66/omarchy-wizard-theme
```

Update it with `omarchy theme update`.

## Usage

To change a color, edit `colors.toml`, then run:

```bash
tools/images.sh
tools/vscode.sh
omarchy theme set wizard
```

`tools/images.sh` needs ImageMagick 7. `tools/vscode.sh` needs jq. Both need
Omarchy. Reload open VSCodium windows to see the change.

## Structure

| Path | Holds |
|---|---|
| `colors.toml` | Every color. Omarchy generates the other configs from it. |
| `icons.theme` | The icon theme name, `Papirus-Pixel`. |
| `vscode-theme.json` | VSCodium colors, made by `tools/vscode.sh`. |
| `shell.font.toml` | Launcher icons at 28 px. |
| `backgrounds/1-omarchy.png` | The wallpaper, 3840 by 2160. |
| `unlock.png` | The wordmark for the unlock screen. |
| `preview-unlock.png` | The thumbnail for the unlock screen picker. |
| `tools/images.sh` | Makes the three images from `colors.toml`. |
| `tools/vscode.sh` | Makes `vscode-theme.json` from `colors.toml`. |

## Not Done

- It does not install the icons. Without them, GTK uses its default icons.
- It has no `preview.png`. The theme picker shows the wallpaper.
- It has no Neovim or terminal config. Omarchy makes those from `colors.toml`.
- Papirus-Pixel in `~/.local/share/icons` changes the Super+Space icons for
  every Omarchy theme, not only this one.

## Decisions

1. The icons are Papirus-Pixel, installed per user in `~/.local/share/icons`.
2. `colors.toml` is the only source of color.
3. Every color is a gray, except one blue accent and a red for errors.
4. The accent is `#738eb9`.
5. Launcher icons are 28 px.
6. Muted is `#64718a`, so borders and dim text stay readable.
7. VSCodium separates panes by tone, with faint borders.

## License

The Unlicense, see [LICENSE](LICENSE). The pixel wordmark in the three
images is Omarchy's, under the MIT license in
[docs/omarchy-license.txt](docs/omarchy-license.txt).
