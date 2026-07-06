# security/ — the AI security team

Self-contained workspace for keeping the platform defensible: audits, dependency and secret
hygiene, access review. A solopreneur has no one else watching this — this team is the
someone. For normal dev work, ignore this folder.

## Trigger

- Owner-invoked: "security pass", "audit before launch", "are we exposed to X".
- Standing cadence (owner runs it, e.g. monthly): the audit checklist below.

## The audit checklist (each run produces a dated report in `audits/`)

1. **Secrets:** scan all repos (orchestrator + `apps/*`) for committed secrets; verify
   `.gitignore`s still cover the shapes in [docs/security.md](../docs/security.md).
2. **Dependencies:** `pnpm audit` (or equivalent) per app; triage criticals into tickets.
3. **Cloud exposure:** with the infra team's [inventory](../infra/inventory/README.md) —
   public buckets, open security groups, unused IAM keys, missing MFA.
4. **Auth surface:** endpoints missing guards, per-app audience checks still enforced.
5. **PII:** where personal data lives, that exports/logs don't leak it.

## Boundaries

- Reads everything; writes **only** inside `security/`.
- Outward actions: tickets in `docs/tickets/open/` — findings ranked by severity, each with a
  concrete exploit scenario and a proposed fix. Fixes ship via the normal dev/infra workflow.
- **Defensive only.** Verify-then-report; never exploit beyond proving reachability.

## Layout

- `audits/` — dated audit reports (`YYYY-MM-DD-audit.md`).
- `notes.md` — standing risk register: accepted risks, owner sign-offs, revisit dates.
