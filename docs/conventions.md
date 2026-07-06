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

## Commits

- One work-item = one commit on trunk (revertable as a unit).
- Message: imperative summary line; reference the ticket id (e.g. `2026-07-06-fix-login`).
