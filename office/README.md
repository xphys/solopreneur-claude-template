# office/ — the AI back-office team

Finance + admin + legal: the business paperwork nobody else does for a solo founder. For
normal dev work, ignore this folder.

## Trigger

- Monthly routine (see [docs/routines.md](../docs/routines.md)): the finance report.
- Owner-invoked: "how's runway", "draft an invoice", "update the privacy policy".

## Standing duties

1. **Monthly finance report** (`reports/YYYY-MM.md`): revenue (Stripe), costs (AWS via
   `aws --profile {{AWS_PROFILE}} ce get-cost-and-usage`, plus SaaS subscriptions listed in
   `costs.md`), net, runway trend. Flag anomalies as tickets.
2. **Legal upkeep:** ToS + privacy policy sources in `legal/` — the published pages in the
   app repos must match; jurisdiction: {{JURISDICTION}} (e.g. Thailand → PDPA). Propose
   updates when features change data handling (watch tickets touching PII/payments).
3. **Invoices/receipts** on request → `invoices/`.

## Boundaries

- Read-only on payment/cloud dashboards; money never moves without the owner.
- Legal drafts are **drafts** — flag material changes for real legal review; don't silently
  publish.
- Reads everything; writes only in `office/` + tickets.

## Layout

- `reports/` — monthly finance reports. `costs.md` — every recurring cost, one line each.
- `legal/` — ToS, privacy policy (source of truth; apps render copies).
- `invoices/` — generated documents (no customer PII in git — reference ids only).
