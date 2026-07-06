# Platform overview

> Filled by `/bootstrap`. Keep this to one screen: what the product does, who uses it,
> and how the app repos fit together. A diagram (mermaid) earns its place here.

**{{PLATFORM_NAME}}** — {{ONE_LINE_PITCH}}

## The apps

| App | Repo | What it is | Users |
|---|---|---|---|
| backend | `apps/backend` | {{BACKEND_DESC}} | (API for all frontends) |
| frontend | `apps/frontend` | {{FRONTEND_DESC}} | {{FRONTEND_USERS}} |
| backoffice | `apps/backoffice` | {{BACKOFFICE_DESC}} | internal/admin |
| mobile | `apps/mobile` | {{MOBILE_DESC}} | {{MOBILE_USERS}} |

## How they talk

```mermaid
graph LR
  frontend --> backend
  backoffice --> backend
  mobile --> backend
  backend --> DB[({{DB_SUMMARY}})]
```

- All clients call **only the backend** at `{{API_BASE_URL}}`.
- Auth: {{AUTH_SUMMARY}}
- Hosting: {{HOSTING_SUMMARY}} (details and IaC in [../infra/](../infra/README.md))
