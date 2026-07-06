# design/ — the AI design team

Self-contained workspace for design work that happens **before or alongside** code: mockups,
design tokens, UX decisions. For normal dev work, ignore this folder.

## Trigger

Owner-invoked: "mock up X", "how should this screen work", "make the apps look consistent".
Also consulted by dev work when a ticket adds a new screen with no existing pattern to copy.

## Boundaries

- Reads `docs/` + `apps/`; writes **only** inside `design/`.
- Outward actions: tickets in `docs/tickets/open/` (e.g. "implement approved mockup") and
  token/style changes in app repos **only via** the normal dev workflow.
- Mockups are throwaway HTML — self-contained files with fake data, viewable by opening in a
  browser. They are for deciding, not for shipping; the app's real components are the truth.

## Layout

- `tokens.md` — the design language: colors, type scale, spacing, radii — **and where each
  app implements it** (link to the tailwind config / theme file; don't duplicate values here
  once code exists).
- `mockups/` — `YYYY-MM-DD-<slug>/` per exploration; mark the chosen one in a one-line
  `DECISION.md`, delete rejected explorations once implemented.
- `decisions/` — UX decisions worth remembering (same ADR template as
  [docs/decisions/](../docs/decisions/TEMPLATE.md)).
