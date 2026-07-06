---
name: routines
description: Install, sync, or list the platform's standing scheduled agents from docs/routines.md. Use when the owner says "set up the routines", "enable the nightly QA", or asks what's scheduled.
---

# /routines — manage scheduled agents

The registry is [docs/routines.md](../../../docs/routines.md) — single home for what runs
when. This skill makes reality match it.

1. **List** current scheduled agents (`/schedule` machinery or cron) and diff against the
   registry table.
2. **Install/sync** missing ones. Each schedule's prompt must be self-contained: name the
   routine, link its team charter + the registry row, state the output location and the
   read-and-report rule (no code/infra/deploy changes; file tickets; email
   `{{NOTIFY_EMAIL}}` only for urgent findings).
3. **Preconditions:** don't install a routine whose inputs aren't ready (no uat URL → no
   qa-smoke). Tell the owner what's blocked on what.
4. Owner changes cadence/adds/removes → edit the registry first, then sync.