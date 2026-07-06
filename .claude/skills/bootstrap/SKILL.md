---
name: bootstrap
description: First-run setup of a fresh clone of the solopreneur template — interview the owner, fill every {{PLACEHOLDER}}, configure apps.yaml, and clone the app repos. Use when the repo still contains template placeholders or the owner asks to set up / bootstrap the platform.
---

# Bootstrap a new platform from the template

Goal: after this skill runs, `grep -rn '{{' --exclude-dir=apps --exclude-dir=.git .` returns
nothing, `apps/` is populated, and the TEMPLATE MODE banner is gone from CLAUDE.md.

## 1. Inventory the placeholders

Run `grep -rn '{{' --exclude-dir=apps --exclude-dir=.git .` to list what needs answers.
Core set: `PLATFORM_NAME`, `PLATFORM_SLUG`, `ONE_LINE_PITCH`, `GITHUB_ORG`, `AWS_PROFILE`,
`AWS_REGION`, `NOTIFY_EMAIL`, `PRIMARY_DOMAIN`, `API_BASE_URL`, plus the stack summaries
(auth, DB, payments, notifications, hosting, deploy, schema-change policy, env locations,
test accounts/env, analytics).

## 2. Interview the owner

Ask in batches (use AskUserQuestion where options are enumerable), don't guess:

1. **Identity:** platform name, slug, one-line pitch, primary domain, GitHub org.
2. **Apps:** which of backend/frontend/backoffice/mobile exist (add/remove freely), each
   repo's URL, trunk, and production branch. Do the repos already exist, or create them?
3. **AWS:** profile name, region, notification email (must be a notifications inbox, not the
   owner's personal email).
4. **Stack facts:** auth provider, DB + schema-change policy (migrations vs manual DDL),
   payments, notification channels, hosting/deploy per app, where backend/frontend env lives.
5. **Testing:** which environment QA may test against; where test accounts live.

If the platform already exists (adopting, not greenfield), prefer reading `apps/*` code to
asking — interview only for what code can't tell.

## 3. Apply

- Fill every placeholder across: `CLAUDE.md`, `apps.yaml`, `docs/*.md`, `docs/data/README.md`,
  `infra/**`, `tester/README.md`, `growth/README.md`. Placeholders of the form
  `{{NAME:default}}` — use the default unless the owner overrides.
- Trim/extend `apps.yaml` to the real apps; keep its strict format (setup.sh parses it).
  Mirror any app add/remove in `apps/` folders and `docs/codebases/`.
- Write `docs/codebases/<app>.md` from `docs/codebases/TEMPLATE.md` for each app — from real
  code if it exists, else as a stub to fill after the first feature.
- Remove the **TEMPLATE MODE** banner from CLAUDE.md and the template-usage section from
  README.md (rewrite README's intro to describe this platform).
- Run `./setup.sh` (ask SSH vs HTTPS if unknown). If repos don't exist yet, offer to create
  them with `gh repo create` first.
- Infra: fill `infra/iac/envs/prod/*.tf`; offer to create the tfstate bucket and enable the
  backend now (owner approves the commands).

## 4. Verify and close

- `grep -rn '{{' --exclude-dir=apps --exclude-dir=.git .` → must be empty.
- `./setup.sh` exits 0; each `apps/<name>` is a git repo on its trunk.
- Relative links resolve (spot-check docs/README.md links).
- Commit everything as one commit: `Bootstrap <platform> from solopreneur template`.
- Write the first ticket in `docs/tickets/done/` recording the bootstrap (what was configured,
  what was deferred).