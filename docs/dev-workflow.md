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

## The ticket flow (chat-first, auto-recorded)

The owner commands in chat; the AI works, then records. See [tickets/README.md](tickets/README.md)
for the lifecycle and [tickets/TEMPLATE.md](tickets/TEMPLATE.md) for the format.

1. Owner asks in chat (or, for async work, drops a ticket in `tickets/open/` with `Status: Ready`).
2. AI reads docs → scopes repos touched → implements on a `features/<slug>` branch. Medium/
   large items go through the manager–worker loop (`/build`): the session model plans +
   reviews, workers one model tier below implement, loop until acceptance criteria pass.
   On pass: squash-merge to `main`, delete the branch.
3. AI writes/updates the ticket: plain-language summary, commits/branches, any DDL or infra
   change applied, and **click-through verification steps**. Sets `Status: In review`.
4. Owner verifies from the ticket alone (never has to open code) and confirms → ticket moves
   to `tickets/done/`. If it needs QA, owner sets `Status: For QA` and the
   [tester team](../tester/README.md) picks it up.
5. Owner promotes `main` → `deploy/uat`, verifies in UAT, then `deploy/uat` → `deploy/prod`
   to ship.

**Clarity gate:** if a request is ambiguous, don't guess. Ask in chat, or set
`Status: Need more info` with questions in the ticket's Clarifications section.

## Deploys

> Filled by `/bootstrap` / the infra team: how each app actually deploys from `deploy/uat`
> and `deploy/prod` (e.g. Amplify auto-build per branch; backend via {{DEPLOY_MECHANISM}}),
> and what the UAT environment is. Runbooks live in
> [../infra/runbooks/](../infra/runbooks/README.md).

## Schema changes

{{SCHEMA_CHANGE_POLICY}} — see [data/README.md](data/README.md). Every applied DDL statement
is recorded in the ticket that caused it.
