# Conventions

Cross-repo patterns every change must match. Format: one `##` per convention — the rule in a
few lines + **one exemplar file link** to copy. Never paste code here; never document what the
exemplar already shows.

> Stack-specific sections (API envelope, auth, error handling, state management, naming…) are
> created at bootstrap from the real codebase — don't invent them ahead of the code. If you
> change a convention while implementing, update it here in the same change.

## Testing (selective, spec-first)

- **Unit-test only what breaks silently:** money/credits, pricing, permissions, webhook
  handling, date/timezone logic — the list for this platform: {{SILENT_BREAK_LIST}}.
  No tests for CRUD glue or UI wiring; E2E stays black-box ([tester](../tester/README.md)).
- Tests live in the app repos and run in **CI on every push to `main`** — red main is an
  incident, fix or revert immediately.
- Authorship separation: on `/build` items touching the silent-break list, tests are written
  from the spec by the `test-writer` agent **before** implementation; the dev worker makes
  them green but may not edit them (mechanics: `/build` skill).

## Comments (the knowledge home inside code)

- Comments state what code can't show: *why*, invariants, constraints, external-system quirks.
  Never narrate what the next line does.
- Learned something non-obvious while working in a file (a trap, a hidden coupling, a reason
  something looks wrong but isn't)? Leave it as a comment **at that site** before moving on —
  that's where the next agent will look. Platform-wide traps go to [gotchas.md](gotchas.md)
  instead; never both.

## Commits

- One work-item = one `features/<slug>` branch = one squash-merge commit on `main`
  (revertable as a unit). Delete the branch right after merging.
- Message: imperative summary line; reference the ticket id (e.g. `2026-07-06-fix-login`).
