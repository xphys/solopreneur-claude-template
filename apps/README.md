# apps/ — mount point for the product repos

Each app in this folder is **its own git repository**, cloned here by [`../setup.sh`](../setup.sh)
from the registry in [`../apps.yaml`](../apps.yaml). Nothing under `apps/` is tracked by the
orchestrator repo (see `.gitignore`) — this file is the only exception.

- To add or remove an app, edit `apps.yaml` (the `/new-app` skill does this properly:
  manifest + codebase doc + clone).
- Branch model per app (trunk vs production branch) is declared in `apps.yaml`.
  **Never push to a production branch** — see Golden rule #1 in [`../CLAUDE.md`](../CLAUDE.md).
