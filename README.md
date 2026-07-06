# Solopreneur Platform Orchestrator (template)

A template for running a multi-repo product platform as a **solo founder with an AI team**.
This repo is the orchestrator: it holds the documentation, the work log, and the AI team
workspaces. The actual product code lives in separate git repos mounted under `apps/`.

The daily loop: open this project in Claude Code, say what you want in plain language, and the
AI implements it in the right app repo(s), records a ticket you can verify from, and keeps the
docs true. You review outcomes, not code.

## Using this template for a new platform

1. **Clone the template** into a new folder and re-init git:
   ```bash
   git clone <this-template> my-platform && cd my-platform
   rm -rf .git && git init && git add -A && git commit -m "Bootstrap from solopreneur template"
   ```
2. **Open it in Claude Code and run `/bootstrap`.** The AI interviews you (platform name,
   GitHub org, apps, AWS profile/region, auth/DB/payments stack), fills every `{{PLACEHOLDER}}`,
   trims `apps.yaml` to your real apps, writes the initial docs, and runs `setup.sh`.
3. That's it. From then on, just talk to it.

Manual alternative: `grep -rn '{{' --exclude-dir=apps .` lists every placeholder; fill them,
edit `apps.yaml`, then run `./setup.sh`.

## Layout

| Path | What it is |
|---|---|
| [CLAUDE.md](CLAUDE.md) | The AI's operating manual — golden rules, read order, workflow |
| [apps.yaml](apps.yaml) | Registry of app repos + branch model (source of truth) |
| [setup.sh](setup.sh) | Clones/updates all app repos into `apps/` |
| [docs/](docs/README.md) | Platform documentation — the source of truth the AI reads first |
| [docs/tickets/](docs/tickets/README.md) | Work log — one ticket per substantive change |
| [apps/](apps/README.md) | Mount point for product repos (gitignored, each its own git) |
| [infra/](infra/README.md) | AI infra team — all cloud state as Terraform/OpenTofu in `infra/iac/` |
| [tester/](tester/README.md) | AI QA team — black-box testing, opt-in |
| [design/](design/README.md) | AI design team — mockups, tokens, UX decisions |
| [growth/](growth/README.md) | AI growth team — copy, SEO, analytics |
| [security/](security/README.md) | AI security team — audits, dependency & secret hygiene |
| `.claude/skills/` | Workflow skills: `/bootstrap`, `/build`, `/ticket`, `/status`, `/new-app` |
| `.claude/agents/` | Subagent roles: `worker` (implementer for the `/build` loop; model set by the ladder) |

## Principles

- **The orchestrator never vendors app code.** `apps/*` is gitignored; each app repo stands alone.
- **Docs describe only what code can't tell** — wiring, schema, conventions, gotchas, decisions.
- **Chat-first, ticket-recorded.** No ceremony to start work; full traceability after it.
- **Infrastructure is code.** Nothing exists in the cloud unless it's in `infra/iac/`.
- **Short-lived branches, clean history.** Development happens on `features/<slug>`,
  squash-merged to `main` and deleted immediately. `deploy/uat` and `deploy/prod` are
  protected, deploy-only, and promoted manually by the owner (`main` → uat → prod).
- **Manager–worker execution.** The session model is the manager — it plans, reviews, and
  holds the quality bar; workers one tier below implement from self-contained specs; the loop
  repeats until acceptance criteria pass. Swap cost tiers by changing the session model
  (`/model`) — the ladder follows. See `/build`.
