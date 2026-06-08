---
name: wiki-onboard
description: >
  Set up (or re-map) an Obsidian company wiki by interviewing the user about
  their domain, then writing the domain language (CONTEXT.md), the wiki section
  folders, and the source types with their property templates. Based on the
  grill-with-docs method. Use when the user says "set up my wiki", "onboard",
  "map my domain", "configure the wiki", "start a company wiki", or when source
  folders / CONTEXT.md have not been set up yet.
---

# Wiki Onboard

Shape a blank template into *this team's* wiki. You do it by grilling the user
about how they work, capturing the domain language, and deriving both the
**output** (wiki sections) and the **input** (source types and their fields)
from that language.

This skill owns **structure** — `CONTEXT.md`, the section folders, and the
source schema. Day-to-day content is `wiki-distill`'s job.

## Method: grill, then write

Run this as a relentless, **one-question-at-a-time** interview in the style of
the bundled `grill-with-docs` skill ([../grill-with-docs/SKILL.md](../grill-with-docs/SKILL.md)).
For each question, give your recommended answer, and resolve one branch before
moving to the next. Write artifacts *inline* as decisions crystallise — don't
batch them to the end.

## Flow

### 1. Grill — understand the work
Interview the user about what they do, who they deal with, and what they need to
remember. Probe with concrete scenarios. Sharpen vague or overloaded words into
precise terms.

### 2. Map the domain → `CONTEXT.md`
As terms resolve, write them into a root `CONTEXT.md` using the format in
[../grill-with-docs/CONTEXT-FORMAT.md](../grill-with-docs/CONTEXT-FORMAT.md):
Language (with "avoid" aliases), Relationships, an example dialogue, and flagged
ambiguities. Keep definitions tight, and include only domain terms — not generic
concepts. `CONTEXT.md` is what `wiki-distill` reads to route sources correctly.

### 3. Suggest wiki sections → `wiki/<section>/`
From the domain language, propose the **navigable sections** of the wiki. This
is a *designed information architecture, not a type list* — a domain may have 30
terms but only 4–6 sections. Get the user's approval, then:

1. Create each `wiki/<section>/` folder and its `index.md`.
2. Link every section from the root `wiki/index.md` (which links to first-level
   directories only — progressive disclosure; every directory has its own `index.md`).

Ship one example entity page in a section so the expected format is obvious.

### 4. Understand the sources
Ask what kinds of material will feed the wiki (e.g. emails, meeting transcripts,
contracts, web clips). Turn each into a `#source/<type>` tag. Don't hardcode
universal categories — infer them from this team's actual work.

### 5. Create source property templates
For each source type, write a `sources/_template-<type>.md`. Every template
shares the **common base**, plus a few **type-specific extras** the type needs:

```md
---
# common base — on every source
submitted_by:
captured_at:
source_date:
tags:
  - source/<type>
  - status/pending
# type-specific extras (examples — pick what the type needs)
#   email:      from, to, thread
#   transcript: attendees, meeting_date
#   contract:   counterparty, effective_date
---

> [!note] Distill guidance (optional)
> The user may add steering for distill here. Keep the callout even when empty.

## Source

Paste or clip the raw source content here.
```

Record the full per-type schema in `CLAUDE.md` so `wiki-distill` can rely on it.
The `web-clip` template doubles as the Obsidian Web Clipper template.

## Ownership & maintenance

- `CONTEXT.md` and the section list are **grill-owned**. `wiki-distill` only
  *suggests* new terms or sections (into `open-questions.md`); a human re-runs
  this skill to fold them in. The domain model never drifts unsupervised.
- **No ADRs.** Record notable setup decisions in `meta/maintenance-log.md`.

## Idempotency

- **Discover before you create.** If `CONTEXT.md`, sections, or templates already
  exist, adapt and extend them — never clobber. Ask before changing existing files.

## Anti-patterns

- Don't hardcode universal source categories — ask or infer them.
- Don't introduce sync, permissions, review workflows, or integrations.
- Don't make the user hand-edit YAML — you write the templates for them.
- Don't map every domain term to a folder — design the IA deliberately.
