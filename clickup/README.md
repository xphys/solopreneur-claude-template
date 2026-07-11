# ClickUp — local integration (PM-updates channel)

Lets Claude Code work with ClickUp **locally using your own API token**, instead of the
global claude.ai ClickUp connector. This is the owner's channel for **informing project
management**: work happens in `docs/tickets/`, and the human-readable outcome gets written
to ClickUp (see "PM-update workflow" below).

> **TEMPLATE:** this integration is optional. To activate it: copy `.env.example` to
> `.env`, fill your token + workspace ID (Setup below), then map your workspace in
> [WORKSPACE.md](WORKSPACE.md). Skip the folder entirely if you don't use ClickUp.

Two ways in, same token (`clickup/.env`):

1. **[`./cu.sh`](cu.sh) — direct API helper (preferred).** Works in any session with no
   restart, and covers the v3 Docs API (page create/update) that the pinned MCP server
   predates. Run `./cu.sh` with no args for usage; known IDs live in [WORKSPACE.md](WORKSPACE.md).
2. **Local MCP server** — [`@taazkareem/clickup-mcp-server`](https://www.npmjs.com/package/@taazkareem/clickup-mcp-server)
   as a project-scoped server defined in [`../.mcp.json`](../.mcp.json). Tools appear as
   `mcp__clickup__*` — distinct from the cloud connector's `mcp__claude_ai_ClickUp__*`.
   Nice for interactive browsing; needs install + full session restart (Setup below).

## 🚫 Golden rule — the pinned workspace ONLY

**Only ever touch the workspace pinned in `clickup/.env` (`CLICKUP_TEAM_ID`).** It is the
sole allowed workspace. Other workspaces the owner's account can see may belong to
**different companies** — never cross that boundary.

- ✅ **Use `./cu.sh` or the local `mcp__clickup__*` tools** — both are pinned to that
  workspace via `clickup/.env` and cannot reach any other.
- ❌ **Never use the cloud `mcp__claude_ai_ClickUp__*` connector for ClickUp work here** —
  it authenticates as whatever workspace the owner's claude.ai account last connected,
  which may be a different company's. Reading, searching, or writing there crosses a
  company boundary.
- If any tool or result shows a team ID other than the pinned `CLICKUP_TEAM_ID`, **stop** —
  you're in the wrong workspace. Don't read or modify anything; surface it to the owner.

> **Version pin matters.** We pin **0.8.5**, the last free/MIT release. From **0.9+** the
> package became a paid product — its data tools (spaces/folders/lists/tasks) return a
> "Premium Feature Locked" error unless you set a paid `CLICKUP_MCP_LICENSE_KEY`. Don't bump
> the version unless you've bought a license. (0.8.5 covers tasks, lists, folders, comments,
> time tracking, tags, etc. — plenty for normal use.)

## PM-update workflow (what to write, where, how)

The owner uses ClickUp to keep the (non-technical) project-management side informed.
When they say "update ClickUp / inform PM / write to the knowledge base":

- **Where:** doc pages in the owner's **knowledge-base doc** — one page per topic, grouped
  under a parent page (e.g. `SEO`). Tasks in the designated issues list only when the owner
  asks for something trackable. All IDs: [WORKSPACE.md](WORKSPACE.md).
- **Style — write for a lazy human reader:** status/one-line summary at the top; short
  bullets; tables for comparisons and verdicts; **bold** the decisions; plain language (no
  code refs, no jargon); write in the audience's language. A page is a *briefing*, not
  documentation — `docs/` stays the technical source of truth; ClickUp pages summarize it,
  never replace it.
- **How:** draft the page as markdown in the scratchpad, then
  `./cu.sh page-create <doc_id> "<Name>" draft.md [parent_page_id]` — or `page-update` to
  refresh an existing page (it **replaces** content, so `page-get` first when merging).
  After adding pages, update the page tree in [WORKSPACE.md](WORKSPACE.md).

  Worked example (IDs from the fictional map in WORKSPACE.md):
  ```bash
  ./cu.sh hierarchy                                          # discover space IDs
  ./cu.sh page-list 8x9yz1ab-42                              # page tree of the KB doc
  ./cu.sh page-create 8x9yz1ab-42 "Launch Status" draft.md 8x9yz1ab-104   # new page under "Release Notes"
  ./cu.sh task-create 900000000101 "Fix signup emails" desc.md            # trackable task in "Platform Issues"
  ```

## Layout

| File | What | Committed? |
|---|---|---|
| `cu.sh` | Direct API helper (docs pages, tasks, comments, hierarchy) | ✅ |
| `WORKSPACE.md` | Map of the pinned workspace — space/list/doc/page IDs | ✅ |
| `package.json` / `pnpm-lock.yaml` | Pins the server (`0.8.5`) + `dotenv-cli` | ✅ |
| `.npmrc` | Flat install + lenient engine check | ✅ |
| `.env.example` | Token template | ✅ |
| `.env` | **Your real token** — gitignored; powers both cu.sh and the MCP server | 🔒 |
| `node_modules/` | Installed server — gitignored | 🔒 |
| `../.mcp.json` | Registers the `clickup` server; no secret in it | ✅ |

`../.mcp.json` launches the server **shim-free** — `node` runs `dotenv-cli` (which loads
`clickup/.env`) which runs the server's `build/index.js`. Paths are relative to the repo root
(Claude Code's working dir). No `pnpm`/`npx` at launch, so it's fast and avoids Windows
bin-shim issues.

## Setup

**1. Install the server (once, and after a fresh clone):**
```bash
pnpm -C clickup install
```

**2. Fill your token** in `clickup/.env`:
- `CLICKUP_API_KEY` — ClickUp → Settings → **Apps** → API Token (starts `pk_`).
- `CLICKUP_TEAM_ID` — the number after the domain in your ClickUp URL
  (`app.clickup.com/<TEAM_ID>/...`). This pins the **only** workspace the tools may touch.

**3. Reload MCP** — **fully restart Claude Code** (not just `/mcp` reconnect — the agent's
tool list is built at session start, so new MCP tools only appear after a restart). Approve
the `clickup` server when prompted. Verify with `/mcp` → `clickup` **connected**, then try
"show the ClickUp workspace hierarchy".

## Maintenance

- **Self-test without Claude Code:** the integration can be driven directly over stdio. Ask
  Claude to re-run a probe, or use the `get_workspace_hierarchy` tool once connected.
- **Optional ClickUp Docs tools:** set `DOCUMENT_SUPPORT=true` in `.env`.
