---
name: wiki-lint
description: >
  Health-check an Obsidian company wiki and keep its bookkeeping honest —
  find broken or dangling wikilinks, orphan and un-indexed pages, missing
  section indexes, source-status and citation problems, and risky aliases;
  fix the safe ones, and route judgment calls (contradictions, stale claims,
  missing pages/terms) to the maintenance files. Use when the user says
  "lint the wiki", "health-check the wiki", "check wiki health", "find
  orphans / broken links / contradictions", or "do a wiki maintenance pass".
---

# Wiki Lint

Run a health-check over the whole vault. Verify the structural invariants the
wiki depends on, scan the content for drift, **fix the safe bookkeeping
yourself, and route every judgment call into the maintenance files** — then
report what you changed and what needs a human. Runs are idempotent: linting
twice never duplicates a fix or a routed note.

This skill owns **content and bookkeeping**, like `wiki-distill`. It never
invents wiki sections, never edits the domain model (`CONTEXT.md`), and never
touches a source's raw body — those are out of bounds. When in doubt, flag, don't fix.

## Before you start

1. **Find the vault root** — the folder containing `CLAUDE.md`, `sources/`, and `wiki/`.
2. **Read `CLAUDE.md`** — the conventions are canonical. If anything here conflicts with the vault's `CLAUDE.md`, the vault wins.
3. **Read `CONTEXT.md`** — the domain's ubiquitous language (terms, "avoid" aliases). Use it to judge missing pages/terms. If it's absent, the wiki isn't onboarded yet — say so and stop.
4. **Read `wiki/index.md`** — the live section map. You check coverage against it; you never add a section to it.

## Workflow

### 1. Structural checks (deterministic)
Verifiable invariants — find them with Glob / Grep / Read:

1. **Index presence** — every directory under `wiki/` has an `index.md`.
2. **Dangling links** — every `[[wikilink]]` resolves to a real page (or heading/alias).
3. **Orphans** — pages with no inbound wikilink from any other page.
4. **Index coverage** — each page is listed in its section `index.md`, and each section is linked from the root `wiki/index.md`.
5. **Source integrity** — no source carries both `#status/pending` and `#status/distilled`; every source has a real `submitted_by` (none blank or `unknown`); and report the count of `#status/pending` still waiting (the backlog).
6. **Citation integrity** — every `#status/distilled` source is cited by at least one page, and every entity page cites at least one source.
7. **Alias sanity** — no entity carries a generic single-word `aliases:` entry that would mis-autolink common words.

### 2. Content checks (judgment)
Read the pages and weigh them — these route, they don't auto-fix:

8. **Contradictions** — pages that assert conflicting claims → `wiki/maintenance/contradictions.md`.
9. **Stale claims** — a claim a newer source supersedes → `contradictions.md` (note which source supersedes).
10. **Missing pages** — a concept referenced repeatedly but with no page → "Suggested pages" in `open-questions.md`.
11. **Missing terms** — a domain term in use but absent from `CONTEXT.md` → "Suggested terms" in `open-questions.md`.
12. **Thin pages** — stubs with little beyond a title → "Suggested pages" (flag for enrichment, don't delete).

### 3. Act — fix the safe, flag the rest
Apply this split exactly (it mirrors the ownership rule in `CLAUDE.md`):

The line that decides FIX vs FLAG: **the root `wiki/index.md` is the human-owned section list — never edit it.** Every *child* `index.md` below it is navigation bookkeeping you maintain.

- **FIX** (content/bookkeeping — yours to own):
  - add a page that's missing from its section's `index.md`;
  - create a missing `index.md` for a directory that already has pages, listing them (this documents structure that already exists — it doesn't invent a section);
  - add an obvious, clearly-correct missing cross-reference;
  - repair a wikilink whose intended target plainly exists under another name or alias.
- **FLAG / ROUTE** (structure & judgment — humans own) — append to the **named heading**, and only if the entry isn't already there:
  - contradictions and stale claims → `## Items` in `contradictions.md`;
  - a concept that needs its own page, and thin/stub pages → `## Suggested pages` in `open-questions.md`;
  - a domain term missing from `CONTEXT.md` → `## Suggested terms` in `open-questions.md`;
  - a source with blank or `unknown` `submitted_by` → `## Needs attribution` in `open-questions.md`;
  - everything else needing a human decision — a top-level directory not in the root `wiki/index.md`, a suggested new section, a source carrying both status tags, a citation gap, a generic alias → `## Questions` in `open-questions.md`.
- **NEVER**: add a section to the root `wiki/index.md`, create a new top-level section directory, edit `CONTEXT.md`, edit or re-status a source, or delete any page or source.

### 4. Log the pass
Append one line to `meta/maintenance-log.md`: date, who ran it, and a short summary (e.g. `fixed 3, flagged 5`).

### 5. Report
Give a grouped summary with counts: **fixed** (what you changed), **flagged** (routed to contradictions / open-questions, with where), **suggested** (pages/terms proposed). End with the `#status/pending` backlog count.

## Guardrails

- **Idempotent** — re-check before writing; never duplicate an existing index entry, contradiction, or suggestion. Linting twice is safe.
- **Sources are immutable** — read them for status and citation checks only; never edit a body, flip a status, or delete a source. Leave any `> [!note] Distill guidance` callout intact.
- **Humans own structure** — never create a section and never edit `CONTEXT.md`; only suggest, into `open-questions.md`.
- **Fix only the unambiguous** — if a repair needs a judgment call, flag it instead.
- **No web search in v1** — verify links and claims against vault contents only; don't reach outside the vault.
- **Obsidian-native** — keep type/status as tags, who/when as properties, citations/cross-references as wikilinks, entity aliases precise.

## Quality checklist

- [ ] Every `wiki/` directory has an `index.md`; every page is in its section index and every section is in the root index.
- [ ] No dangling wikilinks remain (repaired where the target was unambiguous, flagged otherwise).
- [ ] Orphan and thin pages were surfaced.
- [ ] No source carries both status tags; blank/`unknown` attribution was routed to "Needs attribution"; the `#status/pending` backlog was reported.
- [ ] Distilled sources are cited and pages cite their sources; gaps were flagged.
- [ ] Generic single-word aliases were surfaced (flagged, not silently removed).
- [ ] Contradictions, stale claims, and suggested pages/terms were routed — without duplicating existing entries.
- [ ] No section created, `CONTEXT.md` untouched, no source body edited, nothing deleted.
- [ ] The pass is logged in `meta/maintenance-log.md`.
