# Smoke pack — the minimum "is it alive" pass

Run against **uat** ([docs/environments.md](../docs/environments.md)) nightly (qa-smoke
routine) and **before any prod promote** (`/promote` runs this as the gate).

Keep it small (≤ 15 min) and critical-path only — deep testing lives in `plans/`. Filled at
bootstrap; grows only when a prod incident proves a path belongs here.

| # | Path | Steps | Pass = |
|---|---|---|---|
| 1 | each app loads | open each app URL | no error page, login screen renders |
| 2 | auth | log in with test account | lands on home, token accepted by API |
| 3 | {{CORE_FLOW_1}} | {{...}} | {{...}} |
| 4 | payments (test mode) | {{...}} | webhook credits correctly |

Result → `reports/smoke-YYYY-MM-DD.md` (pass/fail per row). Any fail before a prod promote =
**promotion blocked**, ticket filed.
