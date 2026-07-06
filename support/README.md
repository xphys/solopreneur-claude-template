# support/ — the AI support team

Handles users so problems become tickets, not lost chats. For normal dev work, ignore this
folder.

## Trigger

- Owner forwards/pastes a user report ("user says payment failed") or asks for inbox triage
  of {{SUPPORT_CHANNELS}} (e.g. LINE OA, support email).
- The nightly/weekly routines may hand it unprocessed reports (see
  [docs/routines.md](../docs/routines.md)).

## The triage loop

1. **Understand** the report; check [faq.md](faq.md) — known issue with a known answer → reply
   draft from `macros/`, done.
2. **Reproduce** on uat (or read-only on prod) using [docs/environments.md](../docs/environments.md).
3. **Real bug** → ticket in `docs/tickets/open/` (repro steps, user impact, severity).
   **User error / gap** → update [faq.md](faq.md) so next time is step 1.
4. **Draft the reply** for the owner to send (owner sends; the team never messages users
   directly unless the owner has authorized a channel).

## Boundaries

- Reads everything; writes only in `support/` + bug tickets. Never touches user data beyond
  what the report needs; PII never committed.

## Layout

- `faq.md` — known issues + answers (the team's memory).
- `macros/` — reply templates per situation, in the product's language ({{SUPPORT_LANGUAGE}}).
- `log.md` — dated triage log: report → outcome (ticket id / faq / user error).
