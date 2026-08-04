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
aliases: [Acme, Acme Corporation]   # the mentions that should auto-link here
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
tracks (Needs, People, Commercials, Risks, History), and ship the ones that have
claims under them today.

## Citation convention

One claim, one line, one citation — the wikilink closes the bullet:

```md
- Headcount is roughly 240. [[acme-call-2026-08-01]]
```

Cite inline rather than in a footer list: Obsidian's backlinks pane is already
the reverse index, and a `## Sources` section is a second copy that drifts. A
claim several sources confirm carries several links.

## Superseding a claim

The live claim stays on the top-level bullet; the one it replaces moves beneath
it as a dated child, and `updated:` moves to the newer source's date:

```md
- Headcount is roughly 240. [[acme-call-2026-08-01]]
  - Was 180 as of 2026-06-08. [[acme-call-2026-06-08]]
```

This shape only fits when the newer source plainly supersedes the older. Two
sources that simply disagree leave the page as it stands and go to
`wiki/maintenance/contradictions.md`.

## Rules

- **One entity, one page** — a mention matching an existing page's `aliases:` is
  that entity, not a new one.
- **Link entities to each other** with wikilinks, so the graph view is useful.
- **Aliases stay precise** — `Acme`, `Acme Corp`; a generic single word like
  `Ops` would mis-autolink ordinary prose across the vault.
