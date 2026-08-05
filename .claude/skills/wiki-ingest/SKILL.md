---
name: wiki-ingest
description: >
  Ingest outside material into an Obsidian company wiki as `#status/pending`
  source notes. Use when the user wants something from their tools or directories brought into
  the vault — a morning's email, the meeting that just ended, a doc someone
  shared, a Slack thread worth keeping — or hands you the content directly,
  whether or not they name a skill or a folder. Lands sources; distilling them
  is `wiki-distill`'s job.
---

# Wiki Ingest

Bring outside material into the vault. Interpret what the user wants ("today's
emails", "the latest meeting"), fetch it from whatever tool provides it, and
write it into `sources/` marked `#status/pending`. This is the active capture
path — the Obsidian Web Clipper is the only other one, landing clips in
`sources/clippings/`.

The user runs `wiki-distill` afterward, and may add guidance to a source first.

## Connector-agnostic

**Discover** which source tools this session actually has, rather than assuming a
vendor. Typical mappings:

| The user wants | Look for | Source type |
|----------------|----------|-------------|
| emails | Gmail / a mail MCP | `#source/email` |
| meeting transcript | a transcript MCP (Granola / Otter / Fathom), or Drive (Google Meet) | `#source/transcript` |
| a document | Google Drive / a file MCP | `#source/doc` |
| a Slack thread | Slack MCP | `#source/slack` |
| files in a folder | the filesystem — read them directly | by file type |

When the needed connector is missing, name it and say how to connect it. When the
user pastes or points at content directly, skip the fetch and write the note from
what they gave you, asking only for header fields you can't infer.

**Bulk is a different job.** A whole drive, a work directory, a mailbox back to
2024 — that is the first backfill, and it belongs to `wiki-onboard`
(`references/backfill.md`): survey, a plan the user edits, a sample per batch,
then ingest. This skill is the daily path — a batch a user can eyeball. When an
ask is clearly a backfill, say so and hand over rather than writing hundreds of
notes.

## Workflow

### 1. Read the conventions

The vault `CLAUDE.md` **Sources** section holds the canonical header and the
per-type property schema — read it there rather than working from memory. Read `CONTEXT.md` when you need the
domain's terms to name things well.

### 2. Interpret the request

Turn the ask into a concrete query: which tool, and what filter — a date range,
"latest", a search term, a specific item.

### 3. Fetch

Pull the raw content **and** the metadata the header needs: sender, recipients
and date for an email; attendees and date for a meeting; url and site for a clip;
author and date for a doc.

### 4. Write each item as a source note

One note per item, flat in `sources/`, with a kebab-case globally-unique file
name derived from the item — `gmail-acme-pricing-2026-06-08.md`,
`acme-call-2026-06-08.md`.

- **Header** — the common base plus that type's extras, filled from the fetched
  metadata, exactly as `CLAUDE.md` specifies.
- **Guidance callout** — seed the empty `> [!note] Distill guidance` callout, so
  the user has an obvious place to steer the next pass.
- **Body** — the fetched content verbatim, under a `## Source` heading. Summarizing
  is distill's job, and `sources/` is the permanent record.
- **Too big, or not text** — a long PDF, a spreadsheet, a deck, an image. Write
  the header as normal, then an extracted text summary and a path or URL pointer
  to the original, and say in the note that it is a pointer rather than the whole
  item. Never truncate silently mid-item.

**Done when** every fetched item has a note whose header fields are all filled
from real metadata. A field you left blank means the fetch came up short — go
back for it, or record `unknown` and flag it in `open-questions.md`.

### 5. Report

List what you ingested, one line each, and remind the user they can add guidance
to any source before running **distill**.

## Guardrails

- **Sources only** — `wiki/` is untouched by this skill.
- **Land what the tool returned** — the note's body is the fetched content, and a
  source you couldn't fetch is one you report instead of writing.
- **No duplicates** — before writing, check for an existing source with the same
  stable file name, or a matching `source_date` plus subject/title, and skip it.
