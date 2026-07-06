# infra/iac/ — Terraform/OpenTofu root

The cloud's source of truth. Anything not declared here shouldn't exist (Golden rule #2).

## Layout

```
iac/
├── envs/
│   └── prod/          # one root module per environment; prod first, add others if needed
│       ├── backend.tf     # remote state config
│       ├── versions.tf    # terraform + provider version pins
│       ├── providers.tf   # AWS provider, default tags
│       └── main.tf        # composition — instantiate modules here
└── modules/           # reusable pieces (networking, app-service, db, dns…) as they emerge
```

## Remote state (set up once, at bootstrap)

State lives in S3 with locking — **never** local `.tfstate` in git (`.gitignore` enforces).
Recommended: bucket `{{PLATFORM_SLUG}}-tfstate` (versioned, encrypted) + S3 native locking
(`use_lockfile = true`; use a DynamoDB lock table instead on older Terraform).

## Working rules

- Always `AWS_PROFILE={{AWS_PROFILE}}` (or the provider `profile` argument — already set in
  `providers.tf`).
- `plan` output goes in the ticket; **owner approves before any `apply`**.
- Adopting existing resources: use `import` blocks + `terraform plan -generate-config-out`
  to bring click-ops resources under management without recreating them.
- Default tags on everything: `Platform`, `ManagedBy=terraform`, `Env` — set once in
  `providers.tf`.
- Secrets are read from SSM/Secrets Manager at plan time, never written in `.tfvars` in git.
