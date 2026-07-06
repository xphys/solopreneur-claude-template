# HOWTO — the owner's manual

How **you** use this template. (The AI's manual is [CLAUDE.md](CLAUDE.md); this is yours.)

## 1. Start a new platform (once)

```bash
git clone <this-template> my-platform && cd my-platform
rm -rf .git && git init -b main
claude
```

Then say: **`/bootstrap`** — answer the interview (name, repos, AWS, stack, smoke paths).
When it finishes, `apps/` is cloned and every placeholder is filled. Optionally: **`/routines`**
to enable the scheduled agents (nightly QA, weekly audit/report, monthly finance).

## 2. Daily loop

Open the project, then just talk:

| You say | What happens |
|---|---|
| `/status` | One screen: open tickets, repo states, what's ready to test/release |
| "add X to the backend" | AI implements on `features/*`, merges to `main`, writes a ticket |
| "fix: users report Y" | Same, or support-team triage if it's a report, not a bug yet |
| "promote backend to uat" | `/promote` — shows what ships, confirms, pushes `deploy/uat` |
| "release all to prod" | `/promote` — smoke test gates it, confirms, pushes `deploy/prod` |

Your verification loop: read the ticket's **✅ Result → How to verify** steps, click through
them, then say "confirmed" (ticket moves to `done/`) or say what's wrong (AI fixes).

You never read code. You never git manually. If it's ambiguous, the AI asks — answer in chat.

## 3. Asking the teams

Address them naturally; each works in its own folder and reports via tickets:

- **QA:** "set ticket X for QA" / "regression pass on booking" → [tester/](tester/README.md)
- **Infra:** "add a Redis cache" / "why is the AWS bill up" → [infra/](infra/README.md) — all
  changes are Terraform plans you approve before apply
- **Design:** "mock up the new dashboard" → [design/](design/README.md) (HTML mockups to open
  in a browser)
- **Growth:** "review landing copy" / "why did signups drop" → [growth/](growth/README.md)
- **Security:** "security pass before launch" → [security/](security/README.md)
- **Support:** paste a user complaint → triage, repro, ticket + reply draft → [support/](support/README.md)
- **Office:** "how's runway" / "draft invoice for X" → [office/](office/README.md)
- **Ideas:** "add to ideas: ..." / "move X to now" → [docs/product/](docs/product/README.md)

## 4. Cost dial

`/model` sets the manager tier; workers follow one tier below automatically (Fable→Opus,
Opus→Sonnet). Drop a tier for routine work; use the top tier for payments/auth/cross-repo work.

## 5. What protects you (don't fight these)

- `deploy/uat` / `deploy/prod` are only ever pushed via `/promote`, on your command.
- Prod promotes are blocked by a failing smoke test unless you explicitly override.
- One work-item = one commit on `main` → anything reverts cleanly: "revert ticket X".
- No secrets in git; infra changes only through Terraform plans you approve.

## 6. When things go wrong

- "revert ticket X" — rolls `main` back; promote to redeploy.
- Broken prod → "roll back prod for backend" (AI uses the rollback runbook).
- AI stuck / ticket `Blocked` → the ticket says exactly what it needs from you.
- Session ended mid-work → new session, `/status`, continue.
