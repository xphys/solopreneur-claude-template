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
- `growth/` — the **AI growth team's** workspace (copy, SEO, analytics, changelog).
- `security/` — the **AI security team's** workspace (audits, dependency & secret hygiene).
- `support/` — the **AI support team's** workspace (user-report triage → tickets, FAQ, reply drafts).
- `office/` — the **AI back-office team's** workspace (finance reports, costs, invoices, legal).
- Standing automation is registered in [docs/routines.md](docs/routines.md) (`/routines` skill).

Team workspaces read `docs/` + `apps/` but keep their artifacts in their own folder; their only
outward actions are tickets in `docs/tickets/` and owner-approved changes. For normal dev work,
ignore them.

## How the owner works (the daily loop)

**Chat-first.** The owner opens this project and asks or commands in plain language. You do the
work, then **record it yourself** as a ticket the owner verifies without reading code
(`/ticket` skill; full lifecycle: [docs/tickets/README.md](docs/tickets/README.md)).
Ambiguous request → **don't guess**, ask. **Respond short:** the owner is an experienced
developer — minimal answers, no background explanation unless asked for detail.

## Multi-agent execution (manager–worker)

For medium/large implementation tasks, don't implement in the main loop — run the
**manager–worker loop** (`/build` skill). Roles are fixed, models are not: the main session
is the **manager** (plans, writes self-contained specs, verifies, reviews, commits, tickets);
**worker subagents** (`.claude/agents/worker.md`) implement, running **one model tier below
the manager** per the ladder in `/build` (owner sets the session model with `/model`; workers
follow automatically). Fix rounds loop to the same worker, max 3, then escalate. Workers
never commit. Trivial fixes skip the loop; mechanical bulk work uses the cheapest tier.

## Read order for any task

Start at [docs/README.md](docs/README.md) — it is the index and defines the read order.
Minimum before touching code: overview → dev-workflow → the app's codebase doc → gotchas.

## Golden rules

1. **Branch model: `features/<slug>` → `main` → `deploy/uat` → `deploy/prod`.** Develop on a
   short-lived `features/*`, squash-merge to `main`, **delete the branch immediately**.
   **Never push to `deploy/*`** — promotion is owner-triggered only (`/promote` skill).
   Full rules + diagram: [docs/dev-workflow.md](docs/dev-workflow.md).
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

## Doc policy — single home for every fact

Every piece of knowledge lives in **exactly one place**; everything else links to it. Never
maintain the same truth in code and doc — that sync always loses. The placement ladder:

1. **Code itself** — first choice. Express knowledge through naming, types, and structure so
   it needs no explanation at all.
2. **Comments in the code** — for what code can't show: the *why*, invariants, constraints,
   external quirks ("Stripe sends this webhook twice"), and non-obvious things learned while
   working there. If an explanation can sit next to the code it explains, it MUST live there
   — not in `docs/`. Another agent gains this knowledge by reading the code, and it travels
   with the code when it changes.
3. **`docs/`** — only what no single code file can hold: cross-repo wiring, DB schema (when
   there are no migrations), infra/env, conventions (the rule + one exemplar link), gotchas,
   decisions/history. Docs **index and point into** code; they never restate it.

Enforcement: if a doc restates code, replace it with a link (and move any surviving insight
into a comment at the code site). Docs' only sync duty is staying a correct index — which is
cheap precisely because the doc surface stays small.

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
