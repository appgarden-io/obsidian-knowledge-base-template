---
name: wiki-onboard
description: >
  Onboard an Obsidian company wiki: read the kickoff pack in `PROFILE.md`, draft
  the wiki from it, grill the user about what it left open, then write
  `CONTEXT.md`, the wiki sections, and the source templates. Use when the user
  wants to start a wiki or reshape one — setting it up, describing how their team
  works, or finding the sections no longer fit — and whenever `CONTEXT.md` or the
  source templates are missing. Owns structure: sections and the domain model
  change only here.
---

# Wiki Onboard

Shape a blank template into *this team's* wiki. The user has usually already sat
through a kickoff interview, and its **kickoff pack** ships in the vault as
`PROFILE.md`. Read it, derive both the **output** (wiki sections) and the
**input** (source types and their fields) from it, and spend the user's
attention only on what the pack could not settle.

This skill owns **structure** — `CONTEXT.md`, the section folders, and the source
schema. Day-to-day content is `wiki-distill`'s job.

## Method: read, propose, grill the gaps

The pack is a long interview the user has already given. **Do not make them give
it again.** Anything the pack states, you take as answered; you come back to them
with a draft and a short list of what is genuinely open.

Where you do ask, ask in the style of the bundled `grill-with-docs` skill
([../grill-with-docs/SKILL.md](../grill-with-docs/SKILL.md)): **exactly one
question per message**, terse — one or two sentences plus a one-line recommended
answer — waiting for the answer before the next. Write artifacts *inline* as
decisions crystallise rather than batching them to the end.

A fact discoverable from files already in the vault is one you look up instead of
asking.

## Flow

### 1. Read the profile

Look for `PROFILE.md` at the vault root, then `profile/` (several interviewees →
several packs), then any already-filed `sources/kickoff-*.md` from an earlier
pass. The format, and what each part of it drives, is
[references/profile-format.md](references/profile-format.md) — read it before
the pack.

**No pack?** Say so plainly, then run the full interview: work through the
kickoff pack's own headings as your agenda — role, part of the business, team
structure, core processes, systems of record, conversations, tooling — one
question per message, until every term the user leaned on has a definition tight
enough to hand a new hire. Then rejoin at step 3.

### 2. Derive the draft — no questions yet

Working only from the pack, draft:

- **The domain language** — `Their words`, near-verbatim.
- **The sections** — led by `Their grouping`, which outranks any tidier
  taxonomy you can think of. A domain with 30 terms may want 4–6 sections.
- **The seed pages** — one per system in `Systems of record`, one per named
  process, plus the entities in `2. Their part of the business`.
- **The source types** — from `6. Conversations` and `7. Current tooling`. Only
  material that will actually land in `sources/` earns a type.

### 3. Propose it, then grill only the gaps

Show the draft **in one message**: the sections with a line on what each holds,
the source types, and the terms you are taking as canonical. Ask for edits.

Then work the gap list from
[references/profile-format.md](references/profile-format.md) — ambiguous terms,
gaps that would change the section list, entity-or-section calls, what will
really land in `sources/`. **At most five questions**, one per message, most
structural first. Everything else the pack left open goes to
`wiki/maintenance/open-questions.md`, not to the user.

**Done when** the user has approved a section list, and you could say which
section any fact in the pack would file into.

### 4. Write `CONTEXT.md`

Write the domain language into a root `CONTEXT.md` in the format at
[../grill-with-docs/CONTEXT-FORMAT.md](../grill-with-docs/CONTEXT-FORMAT.md):
Language (with "avoid" aliases), Relationships, an example dialogue, flagged
ambiguities. Keep definitions tight and the terms domain-specific — `CONTEXT.md`
is what `wiki-distill` reads to route sources.

Prefer the user's own wording from `Their words` over a cleaner phrasing of your
own.

### 5. Build the sections → `wiki/<section>/`

1. Create each `wiki/<section>/` folder and its `index.md`.
2. Link every section from the root `wiki/index.md`, path-qualified
   (`[[customers/index|Customers]]`).

Ship one example entity page so the expected shape is concrete — the format is
[../wiki-distill/references/entity-page-template.md](../wiki-distill/references/entity-page-template.md).
Build it from a real system in `Systems of record`, citing the pack, so the first
page is true rather than illustrative.

Leave the rest of the seed pages to `wiki-distill` — filing the pack (step 7) is
what creates them, with provenance.

### 6. Create source property templates

Write a `sources/_template-<type>.md` per type. Each is the header from the
**Sources** section of `CLAUDE.md` with `source/<type>` filled in and that type's
extras added — the extras being only what the common base doesn't already carry
(a source's own date is always `source_date`).

Record the per-type schema in the `CLAUDE.md` source-types table, so
`wiki-ingest` and `wiki-distill` can rely on it. The `web-clip` template doubles
as the Obsidian Web Clipper template. `kickoff` already ships as a type — leave
its row and template in place.

**Done when** every type named in step 2 has both a template file and a row in
that table.

### 7. File the pack, then log the pass

The pack is raw material, and it already carries `#source/kickoff` and
`#status/pending`. **Move** each pack from the root into
`sources/kickoff-<their-first-name>.md`, content untouched, so the root is clean
and the first `wiki-distill` run folds its facts into the wiki with proper
citations. Do not leave a copy behind, and do not edit what the interview
recorded.

Then record the setup decisions in `meta/maintenance-log.md`, including who was
interviewed and anything from `8. AI use` worth knowing later.

## Guardrails

- **The pack is input, not authority** — nothing in it becomes structure without
  the user approving it in step 3. Where you disagree with `Their grouping`,
  propose the alternative; don't quietly substitute it.
- **Discover before you create** — where `CONTEXT.md`, sections, or templates
  already exist, extend them, and confirm with the user before changing what's
  there.
- **You write the YAML** — the user answers questions; the templates are yours to
  author.
- **The domain model stays supervised** — `wiki-distill` and `wiki-lint` only
  *suggest* terms and sections, into `open-questions.md`. Folding a suggestion in
  means re-running this skill.
