# infra/runbooks/ — operational procedures

Step-by-step, copy-paste-able procedures. One file per procedure, imperative title
(`deploy-backend.md`, `rollback-frontend.md`, `restore-db.md`, `incident-api-down.md`).

A runbook must be executable by an AI agent with no extra context: exact commands (with
`--profile {{AWS_PROFILE}}`), what output to expect, how to verify success, and how to abort.
Write the deploy + rollback runbooks for each app at bootstrap; write incident runbooks the
first time each incident happens.
