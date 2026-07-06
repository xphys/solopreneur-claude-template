# infra/ — the AI infrastructure team

Self-contained workspace of the AI infra/cloud team. It governs the platform's cloud
({{CLOUD_PROVIDER:AWS}}, profile `{{AWS_PROFILE}}`, region `{{AWS_REGION}}`): reads `docs/` +
`apps/`, keeps all artifacts in `infra/`, and acts outward only through tickets in
`docs/tickets/` and **owner-approved** cloud changes. For normal dev work, ignore this folder.

## The one rule: infrastructure is code

**No cloud resource exists unless it is declared in [iac/](iac/README.md)** (Terraform/OpenTofu).

- Change flow: edit IaC → `terraform plan` → show the plan in the ticket → **owner approves** →
  `apply` → record in the ticket.
- Manual console/CLI changes are emergencies only, and must be back-ported into IaC (and
  ticketed) the same day.
- Existing click-ops resources on an adopted platform get **imported** into state
  (`terraform import` / `import` blocks), never recreated blind.

## Layout

| Path | What it is |
|---|---|
| [iac/](iac/README.md) | All Terraform/OpenTofu — the cloud's source of truth |
| [runbooks/](runbooks/README.md) | Step-by-step procedures: deploy, rollback, incidents, restore |
| [inventory/](inventory/README.md) | What exists in the cloud right now (generated, dated) |
| `decisions/` | Infra ADRs — same template as [docs/decisions/TEMPLATE.md](../docs/decisions/TEMPLATE.md) |

## Standing duties

- Keep `inventory/` honest: regenerate after every apply; flag anything in the cloud that
  isn't in IaC (drift) as a ticket.
- Cost watch: budget alarms alert `{{NOTIFY_EMAIL}}`; investigate spikes, ticket findings.
- **Monitoring:** uptime checks on every prod URL + error tracking ({{ERROR_TRACKING}}) wired
  to `{{NOTIFY_EMAIL}}` — provisioned via IaC like everything else.
- **Backups:** automated DB backups in IaC; quarterly restore drill (backup-drill routine in
  [docs/routines.md](../docs/routines.md)) — a backup that's never been restored doesn't count.
- All automated email (SNS, alarms, build notifications) goes to `{{NOTIFY_EMAIL}}` — never
  the owner's personal email.
