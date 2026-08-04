# Entity Page Template

The entity page is the wiki's core artifact: one page per thing the team cares
about (a customer, a person, a product, a policy), built up from many sources
over time. Sources are the archive; this page is the synthesis.

Every page in a domain section follows this shape. `wiki/meetings/` is the one
exception — see [meeting-note-template.md](meeting-note-template.md).

## Frontmatter

```yaml
---
title: Acme Corp
aliases: [Acme, Acme Corporation]   # precise — never a generic single word
tags:
  - entity/customer                 # mirrors the section the page lives in
updated: 2026-06-08                 # date of the newest source folded in
---
```

## Body

```md
# Acme Corp

Mid-market logistics company; customer since 2025. One or two sentences, in the
domain's words, so a reader knows what this is before scrolling.

## Needs

- Wants same-day quote turnaround on freight over 2t. [[acme-call-2026-06-08]]
- Currently on a 30-day billing cycle. [[acme-contract-2025-11-02]]

## People

- [[bob-mendes]] — operations lead, the day-to-day contact. [[acme-call-2026-06-08]]
```

Section headings are the entity's **facets** — pick what the domain actually
tracks (Needs, People, Commercials, Risks, History). Don't ship empty headings.

## Citation convention

**Every claim ends with a wikilink to the source it came from.** One claim, one
line, one citation:

```md
- Headcount is roughly 240. [[acme-call-2026-08-01]]
```

- Cite **inline**, at the end of the claim — not in a footer list. Obsidian's
  backlinks pane already gives you the reverse index; a `## Sources` section
  would be a second copy that drifts.
- A claim confirmed by several sources carries several links.
- No claim without a citation. If you can't point at a source, it doesn't go on
  the page — it goes to `wiki/maintenance/open-questions.md`.

## Superseding a claim

When a newer source changes a fact, **keep the history**. The live claim stays
on the top-level bullet; the old one moves beneath it as a dated child:

```md
- Headcount is roughly 240. [[acme-call-2026-08-01]]
  - Was 180 as of 2026-06-08. [[acme-call-2026-06-08]]
```

Never delete the superseded line and never silently overwrite — the audit trail
back to sources is the point of the wiki. Bump `updated:` when you do this.

If the two claims can't be reconciled — the newer source doesn't obviously
supersede the older, they simply disagree — leave the page alone and route it to
`wiki/maintenance/contradictions.md` instead.

## Rules

- **One entity, one page.** Look before you create; check `aliases:` on existing
  pages before deciding a mention is a new entity.
- **Aliases must be precise.** `Acme`, `Acme Corp` — yes. `Ops`, `The team` — no;
  a generic single word will mis-autolink ordinary prose across the vault.
- **Link entities to each other** with wikilinks, so the graph view is useful.
- **Add the page to its section `index.md`** when you create it.
- **Facts live on the entity page**, even when they surfaced in a meeting. A
  meeting note is a synthesis of one conversation, not the home of the fact.
