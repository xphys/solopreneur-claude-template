# Security & secrets

## Where env/secrets actually live

> Filled by `/bootstrap`. Be exact — this is the doc that prevents "just commit the .env".

- **Backend env:** {{BACKEND_ENV_LOCATION}} (e.g. an S3 env bucket, SSM Parameter Store)
- **Frontend env:** {{FRONTEND_ENV_LOCATION}} (e.g. Amplify console env vars)
- **IaC secrets:** never in `.tfvars` committed to git — use SSM/Secrets Manager data sources.

## Never in git

- `.env` files, API keys, service-account JSON, TLS keys (`.gitignore` blocks the common shapes,
  but the rule is the rule regardless).
- Production data exports — they contain PII.

## Access

- AWS: named profile `{{AWS_PROFILE}}` only; owner holds root. IAM changes go through
  `infra/iac/` like everything else.
- The [security team](../security/README.md) audits dependency and secret hygiene on request.
