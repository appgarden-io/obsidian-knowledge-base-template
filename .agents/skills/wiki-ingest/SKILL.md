---
name: wiki-ingest
description: >
  Fetch material from the user's connected tools (email, meeting transcripts,
  Google Drive, Slack, or any available MCP source) and land it in sources/ as
  properly-formed, #status/pending source notes — ready for wiki-distill. Use
  when the user says "ingest my emails", "check today's emails and add them",
  "ingest the latest meeting", "pull my meeting transcript into the vault",
  "grab that doc from Drive", or otherwise asks to bring outside material in.
  Lands sources only; it does not distill.
---

# Wiki Ingest

Bring outside material into the vault. Interpret what the user wants ("today's
emails", "the latest meeting"), fetch it from whatever tool provides it, and
write it into `sources/` as a properly-formed source note marked
`#status/pending`. This is the active capture path — users rarely drop files by
hand (the Obsidian Web Clipper is the only direct-drop path, into
`sources/clippings/`).

This skill **lands sources only** — it does not distill. The user runs
`wiki-distill` afterward, and may add guidance to a source first (see below).

## Connector-agnostic

Don't hard-wire one vendor. **Discover** which source tools are available this
session and use them. Typical mappings:

| The user wants | Look for | Source type |
|----------------|----------|-------------|
| emails | Gmail / a mail MCP | `#source/email` |
| meeting transcript | a transcript MCP (Granola / Otter / Fathom), or Drive (Google Meet) | `#source/transcript` |
| a document | Google Drive / a file MCP | `#source/doc` |
| a Slack thread | Slack MCP | `#source/slack` |

If the needed connector isn't available, tell the user which one to connect (and
how) rather than failing. Never invent content you couldn't actually fetch.

## Workflow

### 1. Read the conventions
Read the vault `CLAUDE.md` for the source header rules and the per-type property
schema. Read `CONTEXT.md` if you need the domain's terms to name things well.

### 2. Interpret the request
Turn the user's ask into a concrete query: which tool, and what filter (a date
range, "latest", a search term, a specific item).

### 3. Fetch
Query the tool. Pull the raw content **and** the metadata you'll need for the
header (sender / recipients / date for an email; attendees / date for a meeting;
url / site for a clip; author / date for a doc).

### 4. Write each item as a source note
One note per item, in `sources/` (flat). Use a kebab-case, globally-unique file
name derived from the item, e.g. `gmail-acme-pricing-2026-06-08.md`,
`acme-call-2026-06-08.md`.

```md
---
submitted_by: {the user}
captured_at: {today}
source_date: {when the item is from}
tags:
  - source/{type}
  - status/pending
# + per-type extras, filled from the fetched metadata, e.g.
#   email:      from, to, thread
#   transcript: attendees, meeting_date
---

> [!note] Distill guidance (optional)
> Add any steering for distill here — e.g. "focus on the pricing thread",
> "file under the Q3 Acme deal", "ignore the scheduling chatter". Leave blank
> to let distill decide.

## Source

{the raw fetched content, unmodified}
```

- Land the content **raw**. Don't clean or summarize it — that's distill's job, and `sources/` is the permanent record.
- Fill the per-type extras from the fetched metadata.
- Seed the **guidance callout** so the user has an obvious place to steer distill.

### 5. Idempotency
Before writing, check whether a source for this item already exists (same stable
file name, or matching `source_date` + subject/title). If so, skip it — don't
create a duplicate.

### 6. Report
List what you ingested (file names + one line each), and remind the user they can
**add guidance to any source**, then run **distill** when ready.

## Guardrails

- **Sources only** — never distill, never touch `wiki/`.
- **Raw and immutable** — land content unmodified. The only later changes are the
  status flag (by distill) and guidance the *user* adds.
- **Connector-agnostic** — discover tools; degrade gracefully when one is missing.
- **No duplicates** — stable file names; check before writing.
- **Obsidian-native header** — type/status as tags, who/when + extras as properties.

## Reference

- The vault `CLAUDE.md` "Sources" section is the canonical header + per-type schema.
