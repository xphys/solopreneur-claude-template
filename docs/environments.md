# Environments

Where everything runs — the matrix agents (dev, QA, infra) consult before touching anything.
Filled at bootstrap; keep current when infra changes.

| App | prod (`deploy/prod`) | uat (`deploy/uat`) | local |
|---|---|---|---|
| backend | {{PROD_API_URL}} | {{UAT_API_URL}} | {{LOCAL_API}} |
| frontend | {{PROD_FRONTEND_URL}} | {{UAT_FRONTEND_URL}} | {{LOCAL_FRONTEND}} |
| backoffice | {{PROD_BACKOFFICE_URL}} | {{UAT_BACKOFFICE_URL}} | {{LOCAL_BACKOFFICE}} |
| mobile | {{PROD_MOBILE_DIST}} | {{UAT_MOBILE_DIST}} | {{LOCAL_MOBILE}} |

- **What each env points at:** DB — {{ENV_DB_MAPPING}}; auth — {{ENV_AUTH_MAPPING}};
  payments — {{ENV_PAYMENTS_MAPPING}} (e.g. UAT uses Stripe test mode).
- **QA target:** the tester team tests against **uat**; never destructive actions on prod.
- Test accounts: see [../tester/README.md](../tester/README.md).
