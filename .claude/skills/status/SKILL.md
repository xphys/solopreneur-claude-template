---
name: status
description: One-screen platform status — app repo git states, open tickets, and hygiene warnings. Use when the owner opens a session with "status", "where were we", or "what's pending".
---

# Platform status sweep

Produce ONE readable screen, worst news first. Gather:

1. **Open tickets:** list `docs/tickets/open/` — id, title, Status. Flag `Blocked` /
   `Need more info` / `For QA` first; they're the owner's queue.
2. **App repos:** for each app in `apps.yaml`: current branch, dirty files
   (`git status --porcelain`), and ahead/behind vs `origin/<trunk>` after a `git fetch`.
   Flag: uncommitted work, unpushed commits, a checkout not on trunk, missing clone
   (suggest `./setup.sh`).
3. **Trunk vs production:** per app, `git log --oneline <production>..<trunk> | wc -l` —
   commits shipped to trunk but not yet promoted. This is the "ready to release" number.
4. **Hygiene (mention only if wrong):** leftover `feature/*` branches already merged;
   `{{` placeholders still present; tickets sitting in `In review` for a long time.

Format: a short table for the repos, a bullet list for tickets, one line per warning.
No prose padding — this runs at the start of most sessions.