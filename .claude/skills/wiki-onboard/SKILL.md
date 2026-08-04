---
name: wiki-onboard
description: >
  Onboard an Obsidian company wiki from the kickoff pack in `PROFILE.md`: draft
  its structure from the pack, settle what the pack left open, then fill the
  vault. Use when the user wants to start a wiki, finds its sections no longer
  fit, or is connecting their systems to it for the first time — and whenever
  `CONTEXT.md` or the source templates are missing. Owns structure: sections and
  the domain model change only here.
---

# Wiki Onboard

Shape a blank template into *this team's* wiki. The user has usually already sat
through a kickoff interview, and its **pack** ships in the vault as `PROFILE.md`.
Read it, derive both the **output** (wiki sections) and the **input** (source
types and their fields) from it, and spend the user's attention only on what the
pack could not settle.

This skill owns **structure** — `CONTEXT.md`, the section folders, and the source
schema. Day-to-day content is `wiki-distill`'s job.

## Method: you draft, the user gates

The pack is a long interview the user has already given. Take what it states as
answered, and come back with a draft plus a short list of what is genuinely open.

Four **gates** punctuate the run: the section list here, then the plan, the
sample and the prune inside the backfill. At a gate the user decides and you
wait. Everything between gates is yours to draft.

Where you ask, ask in the style of the bundled `grill-with-docs` skill
([../grill-with-docs/SKILL.md](../grill-with-docs/SKILL.md)): **exactly one
question per message**, terse — one or two sentences plus a one-line recommended
answer — waiting for the answer before the next. Write artifacts *inline* as
decisions crystallise. A fact the vault already holds is one you look up rather
than ask.

## Flow

### 1. Read the pack

Look for `PROFILE.md` at the vault root, then `profile/` (several interviewees →
several packs), then any already-filed `sources/kickoff-*.md` from an earlier
pass. Read [references/profile-format.md](references/profile-format.md) first —
it holds the pack's shape, what each part drives, and the grill list.

**No pack?** Say so plainly, then run the interview yourself, using the pack's
own headings as the agenda — role, part of the business, team structure, core
processes, systems of record, conversations, tooling. One question per message,
until every term the user leaned on has a definition tight enough to hand a new
hire. Then rejoin at step 3.

### 2. Derive the draft — no questions yet

Working only from the pack, draft:

- **The domain language** — `Their words`, near-verbatim.
- **The sections** — led by `Their grouping`. A domain with 30 terms may want
  4–6 sections.
- **The seed pages** — one per system in `Systems of record`, one per named
  process, plus the entities in `2. Their part of the business`.
- **The source types** — from `6. Conversations` and `7. Current tooling`. Only
  material that will actually land in `sources/` earns a type.

**Done when** every term in `Their words` has a section it would file into.

### 3. Gate: propose, then grill what's open

Show the draft **in one message**: the sections with a line on what each holds,
the source types, and the terms you are taking as canonical. Ask for edits.

Then work the **grill list** in
[references/profile-format.md](references/profile-format.md). **At most five
questions**, one per message, most structural first. Everything else the pack
left open goes to `wiki/maintenance/open-questions.md` rather than to the user.

**Done when** the user has approved a section list.

### 4. Write `CONTEXT.md`

Write the domain language into a root `CONTEXT.md` in the format at
[../grill-with-docs/CONTEXT-FORMAT.md](../grill-with-docs/CONTEXT-FORMAT.md):
Language (with "avoid" aliases), Relationships, an example dialogue, flagged
ambiguities. Keep definitions tight and the terms domain-specific — `CONTEXT.md`
is what `wiki-distill` reads to route sources.

**Done when** every term from `Their words` appears there, in the user's own
wording rather than a cleaner phrasing of yours.

### 5. Build the sections → `wiki/<section>/`

1. Create each `wiki/<section>/` folder and its `index.md`.
2. Link every section from the root `wiki/index.md`, path-qualified
   (`[[customers/index|Customers]]`).

Ship one example entity page so the expected shape is concrete — the format is
[../wiki-distill/references/entity-page-template.md](../wiki-distill/references/entity-page-template.md).
Build it from a real system in `Systems of record`, citing the pack, so the first
page is true rather than illustrative. The remaining seed pages are `wiki-distill`'s
to create when it reads the filed pack.

**Done when** every section has an `index.md`, each linked from `wiki/index.md`.

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

### 7. File the pack

The pack is raw material, and it already carries `#source/kickoff` and
`#status/pending`. **Move** each pack from the root into
`sources/kickoff-<their-first-name>.md`, content untouched, so the first
`wiki-distill` run folds its facts into the wiki with proper citations.

**Done when** the root holds no pack, `sources/` holds one per interviewee, and
what the interview recorded reads exactly as it did.

### 8. Connect their systems and backfill

The vault is now shaped but empty. Offer to fill it, to
[references/backfill.md](references/backfill.md): connect the systems the pack
named, point at the directories their work lives in, and pull a first body of
material into `sources/` through its three gates. `CONTEXT.md` is what tells junk
from signal there, which is why this step comes last.

The user can decline or come back later. Say so, and note it in the log.

### 9. Log the pass

Record in `meta/maintenance-log.md`: who was interviewed, the sections agreed,
what was backfilled, and anything from `8. AI use` worth knowing later.

## Guardrails

- **The pack is input, not authority** — nothing in it becomes structure until
  the step 3 gate. Where a tidier taxonomy than `Their grouping` suggests itself,
  propose it as the alternative and let the user pick.
- **Discover before you create** — where `CONTEXT.md`, sections, or templates
  already exist, extend them, and confirm with the user before changing what's
  there.
- **You write the YAML** — the user answers questions; the templates are yours to
  author.
- **The domain model stays supervised** — `wiki-distill` and `wiki-lint` only
  *suggest* terms and sections, into `open-questions.md`. Folding a suggestion in
  means re-running this skill.
