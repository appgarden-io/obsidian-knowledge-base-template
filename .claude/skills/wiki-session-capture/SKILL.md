---
name: wiki-session-capture
description: >
  Capture what a Claude session settled straight into an Obsidian company wiki,
  skipping `sources/`. Use when the user wants this conversation itself written
  down — the decisions and facts you worked out together. Reads the session in
  context; material from the user's tools is `wiki-ingest`'s job, and notes
  already in `sources/` are `wiki-distill`'s.
---

# Wiki Session Capture

The session is the raw material. Sift it for what it **settled**, fold that into
the pages where it belongs, and leave `sources/` alone — a session is not
archived material, so it lands as knowledge directly.

This skill owns **content**, like `wiki-distill`.

## Before you start

Work from the vault root (the folder holding `CLAUDE.md`, `sources/`, and
`wiki/`). Read `CONTEXT.md` for the canonical terms and their "avoid" aliases —
they decide where each fact lands — and `wiki/index.md` for the sections that
exist, since you create pages inside them.

## Workflow

### 1. Sift the session for what it settled

Read back over the whole conversation, first turn to last, and pull out what it
settled: a decision and the reasoning behind it, a fact about the domain the
user stated, a constraint that shaped the work, a name or term the user chose.

**A claim is settled when the user put it there** — they stated it, chose
between options, or confirmed a proposal of yours. A proposal you made that the
user never answered is unsettled: it goes to `open-questions.md` when it is worth
a second look, and otherwise nowhere.

The mechanics stay behind — what you searched, which files you edited, how a bug
was chased. The wiki keeps the conclusion, not the route to it.

**Done when** every settled item has a destination: a wiki page, a maintenance
file, or a deliberate drop you can name.

### 2. Fold each item into its page

- **Route by term** — find the entity's page in the right section, using
  `CONTEXT.md`'s vocabulary (e.g. `wiki/customers/acme-corp.md`).
- **Create the page** when it doesn't exist but its section does, in the shape of
  [wiki-distill's entity page template](../wiki-distill/references/entity-page-template.md),
  which also carries the rule for superseding a claim a later decision changed.
- **A session claim carries no citation** — there is no source note to point at,
  so the claim ends at its full stop. A `[[link]]` to a session would dangle.
- **Update the index** — a page you created gets listed in its section `index.md`.

### 3. Route the leftovers

So nothing settled is dropped:

- a fact implying a **new section** → "Section candidates" in
  `open-questions.md`, with which of the three justifications in `CLAUDE.md` it
  meets. Short of all three, it is a page in an existing section.
- conflicts with an existing wiki claim → `wiki/maintenance/contradictions.md`
- a concept worth its own page → "Suggested pages" in `open-questions.md`
- a domain term absent from `CONTEXT.md` → "Suggested terms" in `open-questions.md`

### 4. Log the pass

Append one line to `meta/maintenance-log.md`: date, who ran it, what the session
settled and where it landed.

### 5. Report

Pages created, pages updated, what went to open-questions / contradictions, and
what you left behind as unsettled.

## Guardrails

- **`sources/` is untouched** — this skill writes only under `wiki/` and `meta/`.
- **Capture the conclusion, leave the payload** — a session carries pasted
  credentials, keys, and raw customer data. The settled *fact* goes on the page;
  the material it came from stays in the session.
- **Idempotent** — re-read the target page before writing, so capturing the same
  session twice adds nothing the first pass already wrote.
- **Look before you create** — search for the entity, `aliases:` included, before
  adding a page for it; one entity keeps one page.
- **Structure is the human's** — a new section or a `CONTEXT.md` edit is a
  suggestion you write into `open-questions.md`.
