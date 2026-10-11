#!/bin/bash
#
# Regenerate the theme's images from colors.toml.
#
# The pixel wordmark is Omarchy's own: every stock theme ships it as a
# two color backgrounds/omarchy.png and a one color unlock.png. This script
# repaints them with the background, accent and foreground of colors.toml, so
# changing a color there and rerunning this keeps the images in step.
#
# Requires ImageMagick 7 (magick) and an installed Omarchy for the sources.

set -euo pipefail

cd "$(dirname "$0")/.."
SOURCE="${OMARCHY_PATH:-/usr/share/omarchy}/themes/hackerman"

color() {
  grep -E "^$1 *=" colors.toml | cut -d'"' -f2
}

BG=$(color background)
ACCENT=$(color accent)
FG=$(color foreground)
FIELD=$(color lighter_background)

# Wallpaper: the source has exactly two colors, its background and the wordmark.
old_bg=$(magick "$SOURCE/backgrounds/omarchy.png" -format '%[hex:p{0,0}]' info:)
magick "$SOURCE/backgrounds/omarchy.png" -fill "$BG" -opaque "#$old_bg" -fill "$ACCENT" +opaque "$BG" \
  -type TrueColor PNG24:backgrounds/1-omarchy.png

# Plymouth logo: the wordmark alone on transparency.
magick "$SOURCE/unlock.png" -alpha set -channel RGB -fill "$ACCENT" -colorize 100 +channel PNG32:unlock.png

# Plymouth picker thumbnail: the wallpaper with the password field drawn on it.
lock_font=$(fc-match -f '%{file}' 'Font Awesome 7 Free:style=Solid')
magick backgrounds/1-omarchy.png -resize 1920x1080 \
  -fill "$FIELD" -stroke "$FG" -strokewidth 2 -draw "rectangle 818,675 1102,720" -stroke none \
  -fill "$FG" -draw "circle 840,697 843,697" -draw "circle 852,697 855,697" \
  -draw "circle 864,697 867,697" -draw "circle 876,697 879,697" \
  -font "$lock_font" -pointsize 36 -annotate +767+716 $'' \
  preview-unlock.png

echo "Wrote backgrounds/1-omarchy.png, unlock.png, preview-unlock.png"
