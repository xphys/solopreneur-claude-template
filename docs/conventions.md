# Conventions

Cross-repo patterns every change must match. For each convention: state the rule, link one
exemplar file to copy — never paste long code into this doc.

> Filled by `/bootstrap` and maintained as conventions evolve. If you change a convention
> while implementing, update this doc in the same change.

## API response envelope

{{API_ENVELOPE}} — exemplar: `../../apps/backend/{{ENVELOPE_EXEMPLAR}}`

## Auth

{{AUTH_CONVENTION}} — exemplar: `../../apps/backend/{{AUTH_EXEMPLAR}}`

## Frontend patterns

{{FRONTEND_CONVENTION}} — exemplar: `../../apps/frontend/{{FRONTEND_EXEMPLAR}}`

## Naming & structure

{{NAMING_CONVENTION}}

## Comments (the knowledge home inside code)

- Comments state what code can't show: *why*, invariants, constraints, external-system quirks.
  Never narrate what the next line does.
- Learned something non-obvious while working in a file (a trap, a hidden coupling, a reason
  something looks wrong but isn't)? Leave it as a comment **at that site** before moving on —
  that's where the next agent will look. Platform-wide traps go to [gotchas.md](gotchas.md)
  instead; never both.

## Commits

- One work-item = one `features/<slug>` branch = one squash-merge commit on `main`
  (revertable as a unit). Delete the branch right after merging.
- Message: imperative summary line; reference the ticket id (e.g. `2026-07-06-fix-login`).
