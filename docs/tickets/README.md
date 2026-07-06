# docs/tickets/ — the work log

Every substantive change to the platform gets a ticket. In the **chat-first** workflow the
owner just talks; the AI does the work and then writes the ticket itself (the `/ticket` skill).
The ticket is how the owner verifies without reading code — and how the *next* AI session
learns what happened and why.

## Lifecycle

```
open/YYYY-MM-DD-<slug>.md          done/YYYY-MM-DD-<slug>.md
        │                                   ▲
        └── Status: In review ── owner confirms ──┘
```

- **Chat-initiated (the normal case):** AI implements, then writes the ticket from
  [TEMPLATE.md](TEMPLATE.md) into `open/` with `Status: In review` and the Result section
  filled. Owner verifies from the Result alone; on confirmation the ticket moves to `done/`.
- **Owner-initiated (async):** owner copies TEMPLATE.md into `open/`, fills the REQUEST part,
  sets `Status: Ready`. The AI picks it up on next session.
- **Clarity gate:** ambiguous request → `Status: Need more info` + questions in the
  Clarifications section. Never guess.
- **QA is opt-in:** only when the owner sets `Status: For QA` does the
  [tester team](../../tester/README.md) test it (black-box, externally). Bugs the tester team
  finds come back as new tickets in `open/`.
- **Blocked:** `Status: Blocked` + what's needed, then stop.

## Statuses

`Ready` → `In progress` → `In review` → (`For QA` →) moved to `done/`
Side states: `Need more info`, `Blocked`.

## Rules

- Ticket id = filename = `YYYY-MM-DD-<slug>` — reference it in the commit message(s).
- Trivial changes (typos, doc-only tweaks) don't need tickets.
- Every applied DDL statement and every manual infra action **must** appear in the ticket.
- Tickets are append-mostly history: correct them while open; never rewrite ones in `done/`.
