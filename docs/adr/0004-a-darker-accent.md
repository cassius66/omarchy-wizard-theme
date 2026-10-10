# 0004. A darker accent

- Status: Accepted
- Date: 2026-10-10

## Context

After a day of use, the accent from 0003, `#8eaad6`, read as too light: closer
to periwinkle than to a grey wizard's robe.

## Decision

`accent` and `blue` are `#738eb9`. It is `#8eaad6` with OKLab lightness
lowered from 0.73 to 0.64, hue and chroma unchanged. Everything else in 0003
stands.

## Consequences

The wordmark, the active window border and selected menu text are darker.
Accent text on `background` still has a contrast ratio of 5.5 to 1.
