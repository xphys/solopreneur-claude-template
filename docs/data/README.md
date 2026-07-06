# docs/data/ — database documentation

> Filled by `/bootstrap` with the platform's actual DB story. Two common modes:
>
> - **Migrations in the app repo** (Drizzle/Prisma/TypeORM migrations): then this folder holds
>   only what migrations can't tell — ER overview, seeding, conventions — and links to the
>   migration folder as the schema record.
> - **No migrations / manual DDL** (`synchronize: false`, DDL applied by hand): then this folder
>   **is the only schema record.** Keep `schema.md` current, and record every applied DDL
>   statement both here and in the ticket that caused it.

**This platform's mode:** {{SCHEMA_CHANGE_POLICY}}

- DB engine: {{DB_SUMMARY}}
- Schema reference: `schema.md` (create at bootstrap)
- Conventions: {{DB_CONVENTIONS}} (e.g. logical string-ID FKs, soft deletes, timezone handling)
