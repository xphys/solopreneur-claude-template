# Development workflow

## Branch model (per app, declared in [apps.yaml](../apps.yaml))

```
features/<slug> ──squash-merge──▶ main ──promote──▶ deploy/uat ──promote──▶ deploy/prod
(short-lived,                  (trunk,            (protected,            (protected,
 DELETED after merge)           source of truth)   auto-deploys UAT)      auto-deploys prod)
```

- **Develop on `features/<slug>`** off `main` — one branch per work-item, named after its
  ticket slug. Trivial fixes (typos, doc-only) may land on `main` directly.
- **Finish = squash-merge to `main`, then delete the branch immediately** (local + remote:
  `git branch -d` / `git push origin --delete`). Merged `features/*` never accumulate —
  a stale one is hygiene debt that `/status` flags.
- **`deploy/uat` and `deploy/prod` are protected, deploy-only.** Pushing auto-deploys; nobody
  commits on them. Only the owner promotes: `main` → `deploy/uat`, verify there, then
  `deploy/uat` → `deploy/prod`.
- Squash-merge keeps one work-item = one commit on `main`, so any item rolls back with
  `git revert <commit>`. Never `git reset --hard` on a pushed branch.

## The work loop

Owner asks in chat → AI implements on `features/<slug>` (medium/large items via the
manager–worker loop, `/build`) → squash-merge to `main`, delete branch → AI records a ticket
→ owner verifies from the ticket and promotes when ready (`/promote`). Ticket lifecycle,
statuses, and rules: [tickets/README.md](tickets/README.md) — the single home for that.

## Deploys

> Filled by `/bootstrap` / the infra team: how each app actually deploys from `deploy/uat`
> and `deploy/prod` (e.g. Amplify auto-build per branch; backend via {{DEPLOY_MECHANISM}}).
> Environment URLs and what points where: [environments.md](environments.md). Runbooks:
> [../infra/runbooks/](../infra/runbooks/README.md).

## Schema changes

Policy and rules live in [data/README.md](data/README.md) — the single home.
