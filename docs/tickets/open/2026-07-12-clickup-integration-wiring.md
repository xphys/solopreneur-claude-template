# Wire up the new clickup/ integration folder

- **Id:** 2026-07-12-clickup-integration-wiring
- **Status:** In review
- **Repos touched:** docs (this repo)

## 📥 Request

The owner dropped a new `clickup/` folder into the repo (local ClickUp integration:
`cu.sh` API helper + pinned local MCP server) and asked to document it and make sure
the right things are gitignored.

## ✅ Result

- **What changed:**
  - **Gitignore fixed:** the token file `clickup/.env` was already ignored, but the
    ignore rule was also (wrongly) hiding `clickup/.env.example` — the template that
    *should* be committed. Added an exception so `.env.example` files are kept while
    real `.env` files stay out of git. `node_modules/` was already covered.
  - **Created the missing `.mcp.json`** at the repo root — the launcher file the
    clickup README refers to. It registers the local ClickUp MCP server (loads the
    token from `clickup/.env`, no secret inside the file itself).
  - **Installed the pinned server** (`pnpm -C clickup install`, version 0.8.5 — the
    last free release) and smoke-tested: the MCP server boots, and `./clickup/cu.sh
    hierarchy` returned the pinned workspace's spaces from the live API.
  - **Templated the folder:** removed all instance-specific workspace names/IDs from
    the committed files — the pinned workspace lives only in the gitignored
    `clickup/.env`, and `WORKSPACE.md` ships as a fill-in map.
  - **Indexed the folder in CLAUDE.md** (one bullet pointing at `clickup/README.md`,
    per the single-home doc policy — the folder documents itself).
- **Commits / branches:** not committed yet — changes are in the working tree on `main`
  (new `clickup/`, new `.mcp.json`, edits to `.gitignore` and `CLAUDE.md`).
- **DB / DDL applied:** none
- **Infra changed:** none
- **Docs updated:** CLAUDE.md (repo-layout list), this ticket.

### How to verify (click-through)

1. In the repo root, confirm `git status` shows `clickup/` and `.mcp.json` as new, and
   that `clickup/.env` is **not** listed (still ignored) while `clickup/.env.example`
   **is** included.
2. Run `./clickup/cu.sh hierarchy` — you should see your workspace's spaces with IDs.
3. Search the repo for your workspace name / team ID — no hits outside the gitignored
   `clickup/.env`.
4. Fully restart Claude Code and check `/mcp` — a `clickup` server should appear and
   connect (approve it when prompted).
