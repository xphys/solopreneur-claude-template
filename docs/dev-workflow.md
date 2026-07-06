# Development workflow

## Branch model (per app, declared in [apps.yaml](../apps.yaml))

- **Trunk** (usually `main`) is the single development branch and source of truth. Work lands
  here — directly, one work-item per commit, so any item reverts as a unit.
- **Production branch** (e.g. `deploy/prod`) is deploy-only: pushing to it auto-deploys.
  Only the owner promotes trunk → production, after verifying the ticket.
- **`feature/*`** branches are the exception, not the rule:
  - *Gate 1 — start of work:* default is **no branch**. Ask the owner before creating one;
    justified only for multi-day work, throwaway experiments, or changes that would leave
    trunk broken for a while.
  - *Gate 2 — after merge:* **delete immediately**, no need to ask. Never delete deploy branches.
- Roll back trunk with `git revert <commit>`; never `git reset --hard` on a pushed branch.

## The ticket flow (chat-first, auto-recorded)

The owner commands in chat; the AI works, then records. See [tickets/README.md](tickets/README.md)
for the lifecycle and [tickets/TEMPLATE.md](tickets/TEMPLATE.md) for the format.

1. Owner asks in chat (or, for async work, drops a ticket in `tickets/open/` with `Status: Ready`).
2. AI reads docs → scopes repos touched → implements on trunk.
3. AI writes/updates the ticket: plain-language summary, commits/branches, any DDL or infra
   change applied, and **click-through verification steps**. Sets `Status: In review`.
4. Owner verifies from the ticket alone (never has to open code) and confirms → ticket moves
   to `tickets/done/`. If it needs QA, owner sets `Status: For QA` and the
   [tester team](../tester/README.md) picks it up.
5. Owner promotes trunk → production branch when ready to ship.

**Clarity gate:** if a request is ambiguous, don't guess. Ask in chat, or set
`Status: Need more info` with questions in the ticket's Clarifications section.

## Deploys

> Filled by `/bootstrap` / the infra team: how each app actually deploys
> (e.g. Amplify auto-build on production branch; backend via {{DEPLOY_MECHANISM}}).
> Runbooks live in [../infra/runbooks/](../infra/runbooks/README.md).

## Schema changes

{{SCHEMA_CHANGE_POLICY}} — see [data/README.md](data/README.md). Every applied DDL statement
is recorded in the ticket that caused it.
