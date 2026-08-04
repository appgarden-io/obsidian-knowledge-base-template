---
name: wiki-distill
description: >
  Distill pending sources in an Obsidian company wiki into entity pages,
  preserving provenance. Use when the user wants what's been collected turned
  into wiki knowledge — distilling, working through the inbox, catching the
  wiki up on material that has landed — and whenever `sources/` still holds
  notes tagged `#status/pending`.
---

# Wiki Distill

Turn raw sources into compiled wiki knowledge: read every source marked
`#status/pending`, fold the facts that matter into the right wiki pages, and flip
the source to `#status/distilled`.

This skill owns **content**. The domain model (`CONTEXT.md`) and the section list
belong to the human via `wiki-onboard` — you route those decisions to
`open-questions.md` rather than deciding them.

## Before you start

Work from the vault root (the folder holding `CLAUDE.md`, `sources/`, and
`wiki/`). Read `CONTEXT.md` for the canonical terms and their "avoid" aliases —
they decide where each fact lands — and `wiki/index.md` for the sections that
exist, since you create pages inside them.

## Workflow

### 1. Collect pending sources

Find every note tagged `#status/pending` under `sources/`, including
`sources/clippings/`. If there are none, say so and stop.

### 2. Distill each source, one at a time

- **Read it** — header (who/when/type + extras) and body.
- **Honor user guidance** — when the source carries a `> [!note] Distill guidance`
  callout with notes, it steers this pass: what to emphasize, where to file, what
  to ignore, what to flag.
- **Extract** the facts that matter to the domain.
- **Route each fact** to a page, using `CONTEXT.md` terms:
  - Find the entity's page in the right section (e.g. `wiki/customers/acme-corp.md`).
  - When the page doesn't exist but its section does, create it — in the shape
    defined by [references/entity-page-template.md](references/entity-page-template.md),
    which also carries the rule for superseding a claim a newer source has changed.
  - When nothing fits, or the fact implies a **new section**, leave the structure
    alone and note it in `wiki/maintenance/open-questions.md`.
- **Preserve provenance** — every claim ends in a wikilink to this source.
- **Meetings** (`#source/transcript`, or otherwise meeting-like) also get a notes
  page in `wiki/meetings/` — see [references/meeting-note-template.md](references/meeting-note-template.md).
- **Route the leftovers**, so nothing read is dropped:
  - conflicts with an existing wiki claim → `wiki/maintenance/contradictions.md`
  - a concept worth its own page → "Suggested pages" in `open-questions.md`
  - a domain term absent from `CONTEXT.md` → "Suggested terms" in `open-questions.md`
  - missing attribution → `unknown`, plus a follow-up in `open-questions.md`
- **Update the index** — a page you created gets listed in its section `index.md`.
- **Flip the status** — `#status/pending` → `#status/distilled`.

**Done when** a search for `#status/pending` comes back empty. Any source you
couldn't finish stays pending and is named in your report with the reason.

### 3. Log the pass

Append one line to `meta/maintenance-log.md`: date, who ran it, what was
distilled / created / updated.

### 4. Report

Pages created, pages updated, and what landed in open-questions / contradictions.

## Guardrails

- **Idempotent** — you process only `#status/pending` and flip it on the way out,
  so a second run over the same sources is a no-op.
- **Look before you create** — search for the entity, `aliases:` included, before
  adding a page for it; one entity keeps one page.
- **Every `[[link]]` resolves** — to a page that exists, or one you create in the
  same pass.
- **Structure is the human's** — a new section or a `CONTEXT.md` edit is a
  suggestion you write into `open-questions.md`.

## Reference files

- **[references/entity-page-template.md](references/entity-page-template.md)** — the shape of an entity page: frontmatter, facets, citation convention, superseding a claim.
- **[references/meeting-note-template.md](references/meeting-note-template.md)** — lightweight, entity-centric meeting notes format.
