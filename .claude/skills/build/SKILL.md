---
name: build
description: Manager–worker implementation loop — plan the work, dispatch worker subagents (one model tier below the session) with self-contained specs, verify and review their diffs, loop fixes until acceptance criteria pass, then commit and ticket. Use for medium/large implementation tasks; do trivial fixes directly without this.
---

# /build — the manager–worker loop

You (the main session) are the **manager**: you plan, dispatch, verify, review, and land.
The **worker** agent (`.claude/agents/worker.md`) implements. You never trust — you check.

## The model ladder (roles are fixed; models are not)

The manager is **whatever model this session runs** — the owner sets it with `/model` to
trade quality vs cost (e.g. Fable normally, Opus on a budget). Workers run **one tier below
the manager**; pass `model` explicitly on every worker dispatch:

| Manager (session model) | Worker model | Bulk/mechanical model |
|---|---|---|
| fable | opus | haiku |
| opus | sonnet | haiku |
| sonnet | haiku | haiku |

The owner can override per task ("use sonnet workers for this") — their word beats the ladder.
If a worker fails a round on **capability** (it understood the spec but couldn't execute it,
e.g. subtle concurrency or type-system work), retry once with a worker one tier **up** before
burning remaining fix rounds. Never dispatch a worker above the manager's tier.

## 0. Size gate

Trivial/small (one file, obvious change, < ~15 min of work): **do it yourself directly** —
dispatch overhead isn't worth it. Delegate medium/large items only.

## 1. Plan

Read the docs (CLAUDE.md read order) and decompose the request into work-items, each
independently implementable and revertable (one item = one commit). For each item write a
**self-contained spec** — the worker sees nothing else, so it must contain:

- **Goal** — what exists after, in one paragraph.
- **Acceptance criteria** — checkable statements you will verify against, not vibes.
- **Where** — repo (`apps/<name>`), the areas/files involved, one exemplar file to copy.
- **Read first** — links: `docs/conventions.md`, `docs/codebases/<app>.md`, relevant gotchas.
- **Verify with** — exact command(s): build, tests, curl, or run steps.
- **Constraints** — stay in repo X; no commits; no schema/infra changes unless spec'd; what
  is explicitly OUT of scope.

## 2. Dispatch

Per item, first create its branch in the target repo: `git -C apps/<name> checkout -b
features/<ticket-slug>` off up-to-date `main`. Then spawn one `worker` subagent (Agent tool,
`subagent_type: worker`, `model` from the ladder above — always set it explicitly); the worker
edits on that checkout and never switches branches. Independent items → dispatch in parallel;
items touching the same repo → sequential (one checkout), or use worktree isolation.
Mechanical bulk items (renames, repeated edits) use the bulk tier — same spec bar, cheaper hands.

## 3. Verify, then review

When a worker reports back:

1. **Run the verification yourself.** The report's claims don't count; only what you observe.
2. **Read the actual diff** (`git -C apps/<name> diff`) against the acceptance criteria and
   conventions. Check the worker's "Notes for review" risks specifically.
3. Watch for the classic worker failure modes: scope creep, convention drift, deleted code it
   didn't understand, tests weakened to pass.

## 4. Loop

On failure, write a **fix plan** — what is wrong (observed, with output), what was expected,
where to look — and send it to the **same worker** via SendMessage (it keeps its context).
**Max 3 rounds per item.** Three failures means the spec is wrong or the item is bigger than
planned: stop, revert the working tree if it's a mess, and escalate to the owner via a
`Status: Blocked` ticket with what you learned.

## 5. Land

Per passing item, in the app repo: commit on the `features/<slug>` branch (ticket id in the
message), squash-merge into `main` (one item = one commit on `main`), push `main`, and
**delete the branch immediately** — local and, if pushed, remote. Then record via `/ticket`.
Multi-item builds get one ticket per coherent item, cross-linked. Never touch `deploy/*`.