# docs/ — documentation index

The source of truth for the platform. Read in this order for any task:

1. [overview.md](overview.md) — what the platform is and how the apps fit together.
2. [dev-workflow.md](dev-workflow.md) — branching, deploy, and the ticket flow.
3. [codebases/](codebases/README.md) — one doc per app: structure + "how to add a feature".
4. [conventions.md](conventions.md) — cross-repo patterns to match (API envelope, auth, naming).
5. [gotchas.md](gotchas.md) — landmines; read before changing anything.
6. [data/](data/README.md) — database schema and how schema changes are applied.
7. [security.md](security.md) — where secrets/env live; what must never enter git.
8. [decisions/](decisions/README.md) — ADRs: why things are the way they are.
9. [tickets/](tickets/README.md) — the work log.

Editing rules: keep links relative (`codebases/*` link to code as `../../apps/<app>/...`);
docs describe only what code can't tell — link to code instead of restating it.
