# 0006. Launcher icons at 28 px

- Status: Accepted
- Date: 2026-10-10

## Context

At 24 px, from 0005, launcher icons still looked small. 28 and 32 px were
compared on a 1920 by 1080 screen at scale 1.5.

`icon-large` also sizes the text of the polkit password field. At 28 px its
placeholder reads "Enter passwo…", and at 32 px "Enter passw…". Typed dots
are unaffected.

## Decision

`icon-large = 28`. This supersedes the size in 0005.

## Consequences

Launcher icons are 56 percent larger than Omarchy's default of 18 px.

The polkit placeholder is cut off. Icons are no longer pixel exact at any
common scale; at 1.5 each icon pixel covers 1.75 screen pixels.
