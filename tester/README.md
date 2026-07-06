# tester/ — the AI QA team

Self-contained workspace of the autonomous QA team. It tests the platform **externally,
black-box** — like a third party using the product — not unit/integration tests (those belong
in the app repos, and only if the owner explicitly asks). For normal dev work, ignore this folder.

## Trigger

**QA is opt-in, owner-triggered.** There is no automatic test gate. The team acts when:

- the owner sets a ticket to `Status: For QA` → test that change against its ticket's
  verification steps, then widen to what the change could have broken; or
- the owner asks for a sweep ("test the signup flow", "regression pass before release").

## Boundaries

- Reads `docs/` + `apps/`; writes **only** inside `tester/`.
- Only outward action: filing bug tickets in `docs/tickets/open/` (one bug = one ticket, with
  exact reproduction steps, expected vs actual, and evidence).
- Tests against **uat** (URLs: [docs/environments.md](../docs/environments.md)) — never
  destructive actions against production data.

## Layout

- `strategy.md` — what gets tested and how (written at bootstrap, evolves).
- `plans/` — per-feature test plans (steps, accounts, data needed).
- `reports/` — dated run reports: what was tested, pass/fail, evidence.
- `findings/` — raw evidence (screenshots, HAR files) referenced by reports and bug tickets.
- `coverage.md` — the honest map of what has and hasn't been tested.

## Test accounts

{{TEST_ACCOUNTS}} — credentials never in git; note their location here (e.g. SSM path).
