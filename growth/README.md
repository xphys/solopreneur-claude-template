# growth/ — the AI growth team

Self-contained workspace for getting and keeping users: copy, SEO, analytics review, launch
checklists. For normal dev work, ignore this folder.

## Trigger

Owner-invoked: "review the landing copy", "why did signups drop", "prep the launch",
"SEO pass on the marketing pages".

## Boundaries

- Reads `docs/` + `apps/` + analytics ({{ANALYTICS_STACK}}); writes **only** inside `growth/`.
- Outward actions: tickets in `docs/tickets/open/` (copy changes, SEO fixes, tracking gaps) —
  it never edits app code directly.
- Claims need numbers: recommendations cite the metric or search data they're based on, or say
  plainly that they're judgment calls.

## Layout

- `positioning.md` — who the product is for, the promise, the proof (written at bootstrap;
  everything else must agree with it).
- `copy/` — reviewed/proposed copy per surface (landing, onboarding, emails), with rationale.
- `seo/` — keyword targets, page-by-page findings, dated audits.
- `analytics/` — dated reviews: funnel numbers, what changed, hypotheses, proposed experiments.
- `launches/` — per-launch checklist and post-mortem.
