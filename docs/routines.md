# Routines — the team works while the owner sleeps

Registry of standing scheduled agents. Install/sync them with the `/routines` skill (uses
Claude Code scheduled agents / cron). Each routine acts within its team's charter; output goes
to the team's folder + tickets; anything urgent also emails `{{NOTIFY_EMAIL}}`.

| Routine | Cadence | Team charter | Does | Output |
|---|---|---|---|---|
| qa-smoke | nightly | [tester](../tester/README.md) | run [tester/smoke.md](../tester/smoke.md) against uat | `tester/reports/`; bugs → tickets |
| security-audit | weekly | [security](../security/README.md) | the audit checklist | `security/audits/`; findings → tickets |
| weekly-report | weekly (Mon) | — | /status + open-ticket summary + AWS week cost + stale-branch/drift check | `reports/` + email to owner |
| finance-report | monthly (1st) | [office](../office/README.md) | revenue/costs/runway | `office/reports/` |
| backup-drill | quarterly | [infra](../infra/README.md) | restore latest DB backup to scratch, verify, destroy | `infra/runbooks/` report; failures → ticket |

Rules: routines are **read-and-report** — they never change app code, infra, or deploy
branches; they file tickets. Disabled until bootstrap enables them (needs env URLs + creds).
