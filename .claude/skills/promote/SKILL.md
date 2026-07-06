---
name: promote
description: Owner-triggered promotion of an app — main → deploy/uat, or deploy/uat → deploy/prod. The ONLY path allowed to push a deploy/* branch, and only on the owner's explicit command naming the app(s) and target.
---

# /promote — push a deployment branch (owner-triggered only)

Golden rule #1 forbids pushing `deploy/*` — **except** here, on the owner's explicit command.
Never run this on your own initiative.

1. **Resolve** app(s) + target from the command ("promote backend to uat", "release all to
   prod"). prod promotions always come from `uat`, uat from `main` (branches per app in
   `apps.yaml`).
2. **Preview** — per app: fetch, then show `git log --oneline <target>..<source>` with the
   ticket ids involved. For prod: confirm those tickets were verified in UAT.
3. **Smoke gate (prod only):** run the [smoke pack](../../../tester/smoke.md) against uat.
   Any fail = promotion blocked + ticket; the owner can explicitly override.
4. **Confirm with the owner** — app, target, commit list — before pushing. A prod promote
   with unverified tickets gets a warning, not a silent pass.
5. **Execute** — fast-forward the target branch to the source and push:
   `git fetch && git push origin origin/<source>:<target>`. If it can't fast-forward, stop —
   deploy branches must never diverge; surface the state to the owner.
6. **Verify** — watch the deploy if observable (Amplify/pipeline status), then run the
   promoted tickets' verification steps against [the target env](../../../docs/environments.md).
7. **Record** — note the promotion in the affected ticket(s); tickets confirmed shipped move
   to `done/`. Prod promotes: add a user-facing entry to `growth/changelog.md`.