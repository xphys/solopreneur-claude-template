---
name: new-app
description: Add a new app repo to the platform (or remove one) — updates apps.yaml, docs, and the apps/ mount consistently. Use when the owner wants to add another product repo, service, or frontend.
---

# Add (or remove) an app

An app exists in exactly four places; keep them consistent or the next agent inherits drift:

1. **`apps.yaml`** — add the entry (name, repo URL, trunk, uat, production) in the strict
   format. Ask the owner for the branch model; default `main` / `deploy/uat` / `deploy/prod`.
2. **The repo itself** — if it doesn't exist yet, offer `gh repo create <org>/<name> --private`
   and push an initial scaffold (ask what stack; copy conventions from an existing app where
   possible). Create `deploy/uat` and `deploy/prod` from trunk so deploys have targets, and
   protect them (no direct pushes except the owner's promotions). Add a CI workflow (GitHub
   Actions) running the test suite on push to trunk — red trunk = fix or revert.
3. **`docs/codebases/<name>.md`** — from `docs/codebases/TEMPLATE.md`. Also add the app to
   the table in `docs/overview.md` and, if it deploys, ticket the infra team for its
   IaC + deploy runbook.
4. **`apps/<name>/`** — run `./setup.sh` to clone it.

Removal is the reverse, plus Golden rule #5 (verify before deleting): confirm nothing in
`docs/`, `infra/iac/`, or other apps references it; archive the repo rather than deleting it;
record the removal in a ticket.