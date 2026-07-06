---
name: ticket
description: Record a completed (or blocked) piece of work as a ticket in docs/tickets/. Use after finishing any substantive change in a chat-first session, or when the owner says "write this up" / "ticket this".
---

# Write the ticket for work just done

The owner verifies from the ticket alone — they never open code. Write for that reader.

1. **Scope check:** trivial changes (typos, doc-only tweaks) don't get tickets — say so and
   stop. Everything else does, including infra applies and manual DDL.
2. **Create** `docs/tickets/open/YYYY-MM-DD-<slug>.md` from `docs/tickets/TEMPLATE.md`
   (today's date; short kebab slug). If the work spanned several requests in one session,
   one ticket per coherent work-item, not one giant ticket.
3. **Fill 📥 Request** with what the owner asked for *as you understood it* — this is the
   contract they verify against.
4. **Fill ✅ Result** completely:
   - plain-language "what changed" (no code-speak, no file paths as the main narrative);
   - commits per repo (`repo: hash — summary`), branch if not trunk;
   - exact DDL applied, or "none"; infra plan/apply summary, or "none"; docs updated.
   - **How to verify:** numbered click-through steps with real URLs — what to click, what
     they should see. This section is the whole point; make it executable by a non-developer.
5. **Status:** `In review` normally; `Blocked` / `Need more info` with specifics if you
   couldn't finish. Reference the ticket id in the commit message(s) when possible.
6. When the owner confirms in chat, `git mv` the ticket to `docs/tickets/done/`.