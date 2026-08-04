# Meeting Note Template (lightweight)

A short, entity-centric note for a single meeting. The raw transcript stays in
`sources/` as the permanent record; this page is the synthesis, linked to the
entities the meeting touched. Keep it brief — this is a pointer plus synthesis,
not a re-transcription.

## Frontmatter

```yaml
---
title: {Company} {Type} — {Person}
tags:
  - meeting
date: YYYY-MM-DD          # when the meeting happened
attendees: [Bob, Sarah]
aliases: []
---
```

## Body

```md
# {Company} {Type} — {Person}

Source: [[{source-slug}]]   ← link back to the transcript in sources/

## Summary

2–4 sentences. Someone should understand the meeting from this alone.

## Key insights

1. **{Insight title}** — one sentence on what it means and why it matters.
2. ...

## Notable quotes

> "{Quote, ≤25 words}" — {first name}
```

## Rules

- Link people, companies, and terms with `[[wikilinks]]` so they connect in the graph.
- Facts that belong on an entity page (e.g. a customer's needs, a person's role)
  go on that **entity page** with a citation. This note is one conversation's
  synthesis; the entity page is where a fact lives.
- Title has no date (the `date` property carries it). File name is kebab-case
  and globally unique, e.g. `acme-discovery-bob-2026-06-08.md`.
