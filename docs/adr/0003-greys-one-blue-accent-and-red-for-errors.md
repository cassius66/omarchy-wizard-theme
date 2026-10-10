# 0003. Greys, one blue accent, and red for errors

- Status: Accepted
- Date: 2026-10-10

## Context

Vantablack, the most minimal stock theme, maps all 14 of its terminal colours
to greys. That leaves a failed command and a removed line in a diff looking
like any other output. Hackerman uses a single accent hue for nearly
everything.

The look wanted is Gandalf the Grey on a 1990s Unix workstation: slate
blue-grey on near black.

## Decision

`accent` and `blue` are `#8eaad6`. `background` is `#10141b`, a near black
with a blue tint. Red, `#d9796f`, is the only other hue, for errors. Every
other terminal colour, green included, is a cool grey.

## Consequences

Errors and removed lines stand out. Added lines in a diff are grey, not
green, and read only by their `+`.

Programs that colour-code by hue, such as `ls` file types and syntax
highlighting, show shades of grey instead.
