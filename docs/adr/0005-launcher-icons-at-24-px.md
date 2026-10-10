# 0005. Launcher icons at 24 px

- Status: Accepted
- Date: 2026-10-10

## Context

The Super+Space menu draws app icons at the shell's `icon-large` font token,
18 px by default. Papirus-Pixel draws every icon on a 24 by 24 grid, so at
18 px each icon pixel covered 0.75 screen pixels and the art blurred.

A theme can replace the `[font]` section of its `shell.toml` with a
`shell.font.toml`. Omarchy 4.0 also uses `icon-large` for the lock glyph in
the polkit password prompt and the play button of the media widget.

## Decision

`shell.font.toml` sets `icon-large = 24` and keeps `base-size = 12`.

## Consequences

Launcher icons are a third larger, and pixel exact at display scale 1 and 2.
At scale 1.5 they are drawn at 36 physical pixels, 1.5 per icon pixel.

The polkit lock glyph and the media play button are a third larger too. The
polkit prompt was checked at 24 px and still fits.
