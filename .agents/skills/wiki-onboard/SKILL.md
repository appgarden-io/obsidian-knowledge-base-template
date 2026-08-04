---
name: wiki-onboard
description: >
  Onboard an Obsidian company wiki: grill the user about their domain, then
  write `CONTEXT.md`, the wiki sections, and the source templates. Use when the
  user asks to set up, configure, or re-map their wiki, and when `CONTEXT.md` or
  the source templates are missing. Owns structure — sections and the domain
  model change only here.
---

# Wiki Onboard

Shape a blank template into *this team's* wiki. You grill the user about how they
work, capture the domain language, and derive both the **output** (wiki sections)
and the **input** (source types and their fields) from that language.

This skill owns **structure** — `CONTEXT.md`, the section folders, and the source
schema. Day-to-day content is `wiki-distill`'s job.

## Method: grill, then write

Run this as a relentless interview in the style of the bundled `grill-with-docs`
skill ([../grill-with-docs/SKILL.md](../grill-with-docs/SKILL.md)), writing
artifacts *inline* as decisions crystallise rather than batching them to the end.

**Ask exactly one question per message**, and wait for the answer before the
next — resolve one branch of the decision tree before opening another.

**Keep each question terse**: one or two sentences, plus a one-line recommended
answer. A fact discoverable from files already in the vault is one you look up
instead of asking.

## Flow

### 1. Grill — understand the work

Interview the user about what they do, who they deal with, and what they need to
remember. Probe with concrete scenarios. Sharpen vague or overloaded words into
precise terms.

**Done when** every term the user leaned on has a definition tight enough to hand
a new hire, and you could say which section a fact about it would file into.

### 2. Map the domain → `CONTEXT.md`

As terms resolve, write them into a root `CONTEXT.md` in the format at
[../grill-with-docs/CONTEXT-FORMAT.md](../grill-with-docs/CONTEXT-FORMAT.md):
Language (with "avoid" aliases), Relationships, an example dialogue, flagged
ambiguities. Keep definitions tight and the terms domain-specific — `CONTEXT.md`
is what `wiki-distill` reads to route sources.

### 3. Design the sections → `wiki/<section>/`

Propose the wiki's **navigable sections**. This is a designed information
architecture: a domain with 30 terms may want 4–6 sections. Get the user's
approval, then:

1. Create each `wiki/<section>/` folder and its `index.md`.
2. Link every section from the root `wiki/index.md`, path-qualified
   (`[[customers/index|Customers]]`).

Ship one example entity page so the expected shape is concrete — the format is
[../wiki-distill/references/entity-page-template.md](../wiki-distill/references/entity-page-template.md).

### 4. Understand the sources

Ask what material will feed the wiki — emails, meeting transcripts, contracts,
web clips — and turn each into a `#source/<type>` tag. Infer the types from this
team's actual work.

### 5. Create source property templates

Write a `sources/_template-<type>.md` per type. Each is the header from the
**Sources** section of `CLAUDE.md` with `source/<type>` filled in and that type's
extras added — the extras being only what the common base doesn't already carry
(a source's own date is always `source_date`).

Record the per-type schema in the `CLAUDE.md` source-types table, so
`wiki-ingest` and `wiki-distill` can rely on it. The `web-clip` template doubles
as the Obsidian Web Clipper template.

**Done when** every type named in step 4 has both a template file and a row in
that table.

### 6. Log the pass

Record the setup decisions in `meta/maintenance-log.md`.

## Guardrails

- **Discover before you create** — where `CONTEXT.md`, sections, or templates
  already exist, extend them, and confirm with the user before changing what's
  there.
- **You write the YAML** — the user answers questions; the templates are yours to
  author.
- **The domain model stays supervised** — `wiki-distill` and `wiki-lint` only
  *suggest* terms and sections, into `open-questions.md`. Folding a suggestion in
  means re-running this skill.
