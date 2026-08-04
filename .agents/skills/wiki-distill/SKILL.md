---
name: wiki-distill
description: >
  Distill pending sources in an Obsidian company wiki into the wiki itself —
  folding facts into entity pages with citations back to each source, writing
  lightweight meeting notes, and routing leftovers to open-questions and
  contradictions. Use when the user says "distill", "process sources",
  "process the inbox", "distill today's sources", "update the wiki from
  sources", or after new sources have been added to sources/.
---

# Wiki Distill

Turn raw sources into compiled wiki knowledge. Read every source marked
`#status/pending`, fold the meaningful facts into the right wiki pages (each
claim linked back to its source), and flip the source to `#status/distilled`.
Runs are idempotent — distilling twice never double-files a source.

This skill owns **content**. It never invents wiki sections and never edits the
domain model (`CONTEXT.md`) — those are the human's job via `wiki-onboard`.

## Before you start

1. **Find the vault root** — the folder containing `CLAUDE.md`, `sources/`, and `wiki/`.
2. **Read `CLAUDE.md`** — the conventions are canonical. If anything here conflicts with the vault's `CLAUDE.md`, the vault wins.
3. **Read `CONTEXT.md`** — the domain's ubiquitous language. Route entities by these canonical terms and respect the listed "avoid" aliases.
4. **Read `wiki/index.md`** — the live list of sections (the designed IA). You may create pages *inside* existing sections, never new top-level sections.

## Workflow

### 1. Collect pending sources
Find every note tagged `#status/pending` under `sources/` (including `sources/clippings/`). If there are none, say so and stop.

### 2. Distill each source, one at a time
For each pending source:

- **Read it** — header (who/when/type + extras) and body. Never edit the body.
- **Honor user guidance** — if the source has a `> [!note] Distill guidance` callout with notes, follow it: what to emphasize, where to file, what to ignore, conflicts to flag. The user's guidance steers this distill.
- **Extract** the facts that matter to the domain. Skip greetings, small talk, and boilerplate.
- **Route each fact** to the right wiki page using `CONTEXT.md` terms:
  - Find the entity's page in the right section (e.g. `wiki/customers/acme-corp.md`).
  - If the page doesn't exist *but its section does*, create it (look before you create).
  - If nothing fits, or it implies a **new section**, do NOT create the section — add a note to `wiki/maintenance/open-questions.md`.
  - Write the page in the shape defined by [references/entity-page-template.md](references/entity-page-template.md) — frontmatter, facet headings, and how to supersede a claim a newer source has changed without losing the old one.
- **Cite every claim** back to the source with a wikilink at the end of the claim: `Headcount is roughly 240. [[acme-call-2026-08-01]]`.
- **Meetings** (`#source/transcript` or otherwise meeting-like): also create/update a lightweight notes page in `wiki/meetings/` — see [references/meeting-note-template.md](references/meeting-note-template.md).
- **Route the leftovers — never drop them:**
  - Conflicts with an existing wiki claim → `wiki/maintenance/contradictions.md`
  - A concept worth its own page but not yet one → "Suggested pages" in `open-questions.md`
  - A new domain term not in `CONTEXT.md` → "Suggested terms" in `open-questions.md` (do not edit `CONTEXT.md` yourself)
  - Missing attribution → leave the field `unknown` and add a follow-up to `open-questions.md`
- **Update the index** — if you created a page, add it to its section `index.md`.
- **Flip the status** — change the source's `#status/pending` to `#status/distilled`.

### 3. Log the pass
Append one line to `meta/maintenance-log.md`: date, who ran it, and what was distilled / created / updated.

### 4. Report
Tell the user: pages created, pages updated, and what landed in open-questions / contradictions.

## Guardrails

- **Idempotent** — only `#status/pending` is processed, and it flips to `#status/distilled` when done. Running distill twice is safe.
- **Look before you create** — never duplicate an existing page; check first.
- **Sources are immutable** — never edit a source body or delete a source. The only change to a source is the status flag.
- **Humans own structure** — never create a new wiki section and never edit `CONTEXT.md`; route those decisions to `open-questions.md`.
- **No dangling wikilinks** — every `[[link]]` you write must resolve to a real page (or one you create in the same pass).
- **Obsidian-native** — type/status are tags, who/when are properties, citations and cross-references are wikilinks, entity pages carry `aliases:` for auto-linking.

## Quality checklist

- [ ] Any user guidance on a source was applied.
- [ ] Every distilled claim cites its source with a wikilink.
- [ ] Every processed source flipped `#status/pending` → `#status/distilled`.
- [ ] New pages were added to their section `index.md`.
- [ ] Meetings got a `wiki/meetings/` note.
- [ ] Contradictions, suggested pages/terms, and unknowns were routed to maintenance files.
- [ ] No new top-level sections created; `CONTEXT.md` untouched.
- [ ] The pass is logged in `meta/maintenance-log.md`.

## Reference files

- **[references/entity-page-template.md](references/entity-page-template.md)** — the shape of an entity page: frontmatter, facets, the citation convention, and how to supersede a claim.
- **[references/meeting-note-template.md](references/meeting-note-template.md)** — lightweight, entity-centric meeting notes format.
