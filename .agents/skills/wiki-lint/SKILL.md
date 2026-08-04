---
name: wiki-lint
description: >
  Lint an Obsidian company wiki: verify its structural invariants, fix the safe
  bookkeeping, and route judgment calls to the maintenance files. Use when the
  user says "lint the wiki", asks for a health-check or maintenance pass, or
  asks after orphans, broken links, or contradictions.
---

# Wiki Lint

Health-check the whole vault: verify the invariants the wiki depends on, read the
content for drift, **fix the bookkeeping yourself and route every judgment call
into the maintenance files** — then report what you changed and what needs a
human.

This skill owns **content and bookkeeping**, like `wiki-distill`. Structure —
the section list and `CONTEXT.md` — stays the human's. When a repair needs a
judgment call, flag it.

## Before you start

Work from the vault root. Read `CONTEXT.md` for the domain's terms and "avoid"
aliases; you judge missing pages and terms against it, so if it's absent the
wiki isn't onboarded yet — say so and stop. Read `wiki/index.md` for the section
map you check coverage against.

## 1. Structural checks

Deterministic invariants — settle each with Glob / Grep / Read:

1. **Index presence** — every directory under `wiki/` has an `index.md`.
2. **Dangling links** — every `[[wikilink]]` resolves to a real page, heading, or alias. Index links are path-qualified (`[[meetings/index|Meetings]]`).
3. **Orphans** — pages whose only inbound link is their section `index.md`. Nothing in the wiki connects to them by meaning, so the graph can't reach them.
4. **Index coverage** — each page is listed in its section `index.md`, and each section is linked from the root `wiki/index.md`.
5. **Source integrity** — no source carries both `#status/pending` and `#status/distilled`; every source has a real `submitted_by`; and report the `#status/pending` count still waiting (the backlog).
6. **Provenance** — every entity page cites at least one source, and every claim on it carries a citation. Then list any `#status/distilled` source that no page cites: usually a missed fact, occasionally a source that genuinely held nothing — report the list for a human glance rather than flagging each as an error.
7. **Alias sanity** — entity `aliases:` are precise; a generic single-word alias will mis-autolink ordinary prose across the vault.

## 2. Content checks

Read the pages and weigh them. These route — they don't auto-fix:

8. **Contradictions** — pages asserting conflicting claims → `contradictions.md`.
9. **Stale claims** — a claim a newer source supersedes → `contradictions.md`, naming the source that supersedes it.
10. **Missing pages** — a concept referenced repeatedly with no page of its own → "Suggested pages".
11. **Missing terms** — a domain term in use but absent from `CONTEXT.md` → "Suggested terms".
12. **Thin pages** — stubs with little beyond a title → "Suggested pages", for enrichment.

**Done when** all twelve have run against every page in `wiki/` and every note in
`sources/` — a partial sweep reports a clean wiki that isn't one.

## 3. Act — fix the safe, flag the rest

The line that decides FIX from FLAG: **the root `wiki/index.md` is the
human-owned section list.** Every *child* `index.md` below it is navigation
bookkeeping you maintain.

- **FIX** (bookkeeping — yours to own):
  - add a page missing from its section's `index.md`;
  - create a missing `index.md` for a directory that already has pages, listing them — this documents structure that already exists;
  - add an obvious, clearly-correct missing cross-reference;
  - repair a wikilink whose intended target plainly exists under another name or alias.
- **FLAG** (structure & judgment — the human's) — append to the **named heading**, and only when the entry isn't already there:
  - contradictions and stale claims → `## Items` in `contradictions.md`;
  - a concept needing its own page, and thin pages → `## Suggested pages`;
  - a term missing from `CONTEXT.md` → `## Suggested terms`;
  - a source with blank or `unknown` `submitted_by` → `## Needs attribution`;
  - anything else needing a decision — a top-level directory absent from the root index, a suggested section, a source carrying both status tags, a provenance gap, a generic alias → `## Questions` in `open-questions.md`.
- **Hard guardrail** — the root `wiki/index.md`, `CONTEXT.md`, the section directories, and every source stay exactly as you found them, and deletions are never yours to make. Each of those is a FLAG instead.

## 4. Log the pass

Append one line to `meta/maintenance-log.md`: date, who ran it, a short summary
(e.g. `fixed 3, flagged 5`).

## 5. Report

Group with counts: **fixed** (what you changed), **flagged** (routed where),
**suggested** (pages/terms proposed). End with the `#status/pending` backlog.

## Guardrails

- **Idempotent** — re-read the target heading before appending, so a second lint
  adds no index entry, contradiction, or suggestion the first already wrote.
- **The vault is the whole evidence base** — check links and claims against what
  it contains.
- **Fix only the unambiguous** — anything needing a judgment call is a flag.
