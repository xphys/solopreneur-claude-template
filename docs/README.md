# docs/ — documentation index

The source of truth for the platform. Read in this order for any task:

1. [overview.md](overview.md) — what the platform is and how the apps fit together.
2. [dev-workflow.md](dev-workflow.md) — branching, deploy, and the work loop.
3. [codebases/](codebases/README.md) — one doc per app: structure + "how to add a feature".
4. [conventions.md](conventions.md) — cross-repo patterns to match.
5. [gotchas.md](gotchas.md) — landmines; read before changing anything.
6. [data/](data/README.md) — database schema and how schema changes are applied.
7. [environments.md](environments.md) — env matrix: URLs, what points where, QA target.
8. [security.md](security.md) — where secrets/env live; what must never enter git.
9. [decisions/](decisions/README.md) — ADRs: why things are the way they are.
10. [tickets/](tickets/README.md) — the work log and its lifecycle (single home for ticket rules).
11. [product/](product/README.md) — roadmap + idea inbox (owner's product thinking).
12. [routines.md](routines.md) — registry of standing scheduled agents.

Editing rules: keep links relative (`codebases/*` link to code as `../../apps/<app>/...`).
**Single-home policy** (see CLAUDE.md): knowledge lives in code first, code comments second,
docs last — docs hold only what no single code file can (wiring, schema, infra, conventions,
gotchas, decisions) and otherwise index into code, never restate it. Before writing a doc
paragraph, ask: could this be a comment at the code site instead? If yes, put it there and
link.
