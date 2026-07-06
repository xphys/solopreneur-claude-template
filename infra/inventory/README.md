# infra/inventory/ — what exists in the cloud right now

Generated, dated snapshots of actual cloud state — the reality check against `iac/`.

- `aws-inventory-YYYY-MM-DD.md` — resources by service (compute, DB, DNS, buckets, IAM…),
  regenerated after every apply and on request. Keep the latest two; delete older.
- Anything present in the cloud but **not** in IaC is **drift**: flag it in the snapshot and
  open a ticket to import or destroy it.
- Never paste secrets or connection strings into inventory files.
