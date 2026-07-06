# CLAUDE.md

Operating manual for AI agents (and humans) working in this repository.

> **TEMPLATE MODE:** if this file still contains `{{PLACEHOLDER}}` tokens, this is a fresh
> clone of the solopreneur template. Run the `/bootstrap` skill first — it interviews the
> owner, fills every placeholder, and removes this banner. Do not do product work while
> placeholders remain.

## What this repo is

This is the **platform orchestrator** for **{{PLATFORM_NAME}}** — a management + documentation
repo. **It contains no application code.** It holds:

- `docs/` — the platform documentation (architecture, per-codebase references, data model,
  conventions, gotchas). **This is the source of truth — read it before acting.**
- `docs/tickets/` — the work log. Every substantive change gets a ticket (see workflow below).
- `apps/` — a **mount point** where the product repos are cloned (gitignored; each app has its
  own git repo). The registry of app repos is [apps.yaml](apps.yaml); `./setup.sh` clones them.
- `infra/` — the **AI infrastructure team's** workspace. All cloud state is code in
  `infra/iac/` (Terraform/OpenTofu). Start at [infra/README.md](infra/README.md).
- `tester/` — the **AI QA team's** workspace (black-box testing, opt-in). Start at
  [tester/README.md](tester/README.md).
- `design/` — the **AI design team's** workspace (mockups, tokens, UX decisions).
- `growth/` — the **AI growth team's** workspace (copy, SEO, analytics review).
- `security/` — the **AI security team's** workspace (audits, dependency & secret hygiene).

Team workspaces read `docs/` + `apps/` but keep their artifacts in their own folder; their only
outward actions are tickets in `docs/tickets/` and owner-approved changes. For normal dev work,
ignore them.

## How the owner works (the daily loop)

**Chat-first.** The owner opens this project and asks or commands in plain language. You do the
work, then **record it yourself**:

1. Read the relevant docs (order below), scope which app repos are touched, implement.
2. When a work item is done, write a ticket into `docs/tickets/open/` from
   [docs/tickets/TEMPLATE.md](docs/tickets/TEMPLATE.md) — request as understood, what changed,
   any DDL/infra applied, and **click-through verification steps** — set `Status: In review`.
   The `/ticket` skill does this. Trivial changes (typos, doc tweaks) don't need a ticket.
3. The owner verifies from the ticket alone and confirms; then move it to `docs/tickets/done/`.
4. If a request is ambiguous, **don't guess** — ask in chat, or set `Status: Need more info`
   with your questions in the ticket if working async.

## Read order for any task

1. [docs/README.md](docs/README.md) — documentation index.
2. [docs/overview.md](docs/overview.md) — how the apps fit together.
3. [docs/dev-workflow.md](docs/dev-workflow.md) — branching, deploy, ticket flow.
4. The relevant [docs/codebases/](docs/codebases/) doc — structure + "how to add a feature".
5. [docs/gotchas.md](docs/gotchas.md) before changing anything; [docs/data/](docs/data/README.md)
   for schema; [docs/conventions.md](docs/conventions.md) for patterns.

## Golden rules

1. **Work on each app's trunk; never push to a production branch.** Trunks and production
   branches are declared per app in [apps.yaml](apps.yaml) — production branches auto-deploy on
   push; only the owner promotes trunk → production. Default is **no feature branch** (commit
   straight to trunk, one work-item = one commit so it reverts as a unit); create a short-lived
   `feature/*` only when the owner confirms (multi-day work, throwaway experiments, or changes
   that would leave trunk broken). Delete `feature/*` immediately after merge. Roll back with
   `git revert`, never `git reset --hard` on pushed trunk.
2. **Infrastructure is code.** No cloud resource exists unless it is in `infra/iac/`. Manual
   console changes are emergencies only and must be back-ported to IaC (and ticketed) the same
   day. Plan → owner approves → apply.
3. **No secrets in git.** Never commit `.env`, keys, or production data exports (PII). Where
   env actually lives: see [docs/security.md](docs/security.md).
4. **Match existing conventions** — API response envelope, auth patterns, module layout — as
   documented in [docs/conventions.md](docs/conventions.md) and per-codebase docs.
5. **Verify before deleting.** Dead code and orphaned resources may exist; cross-check docs
   (gotchas, schema, conventions) before removing anything.
6. **Notification/alert email is `{{NOTIFY_EMAIL}}`.** Use it for ALL automated email — SNS,
   build/deploy notifications, monitoring/budget alerts. Never the owner's personal email.
7. **AWS CLI: always `aws --profile {{AWS_PROFILE}} ...`.** Never run the AWS CLI without the
   profile. Default region: `{{AWS_REGION}}`.

## Doc policy — docs describe only what code can't tell

In scope: cross-repo wiring, DB schema, infra/env, conventions (pattern + one exemplar file to
copy), gotchas, decisions/history. Never restate code structure in prose — link to the file;
code is always more current. If you find a doc restating code, replace it with a link. If you
change a convention while implementing, update the matching doc in the same change.

## Finalizing / closing a session (artifact cleanup)

When the owner signals they're wrapping up ("keep only the final things", "clean up before I
close"), review everything created **during that session** and remove the non-final byproducts:
scratch scripts, temp files, superseded versions, regenerable artifacts (`node_modules`, build
outputs, caches). Keep final deliverables and gitignored operational secrets the owner wants
retained. Only touch things created in this session; never delete pre-existing files or another
team's artifacts — surface those instead. Then summarize kept vs removed.

## Platform cheat-sheet

> Filled by `/bootstrap`; keep to hard facts the code can't tell.

- **Auth:** {{AUTH_SUMMARY}}
- **API:** {{API_SUMMARY}}
- **DB:** {{DB_SUMMARY}}
- **Payments:** {{PAYMENTS_SUMMARY}}
- **Notifications:** {{NOTIFICATIONS_SUMMARY}}
- **Domains:** {{PRIMARY_DOMAIN}}
- **Editing docs:** keep links relative; `docs/codebases/*` link to code as
  `../../apps/<app>/...`. Run a relative-link check after structural changes.
