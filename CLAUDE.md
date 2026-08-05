# Company Wiki — Claude Instructions

This repository is an Obsidian company wiki: a plain-markdown vault that Claude keeps current for a small, nontechnical team. You read raw sources, distill them into linked wiki pages, and keep the bookkeeping consistent. Favor simple pages and Obsidian-native markup over custom tooling.

## Layout

```text
CONTEXT.md   the team's domain language (glossary) — read before distilling
CLAUDE.md    these conventions
PROFILE.md   the kickoff pack this vault shipped with — setup input, consumed by wiki-onboard
sources/     raw material, flat; sources/clippings/ is the Web Clipper landing zone
wiki/
  index.md     root map → first-level sections only
  meetings/    lightweight notes, one per meeting
  maintenance/ open-questions.md · contradictions.md
  <section>/   designed sections for this domain (created by wiki-onboard)
meta/
  maintenance-log.md       append-only record of distill / onboard passes
  onboarding-progress.md   wiki-onboard's resume state — present only once onboarding has begun
```

## The three documents

- **CLAUDE.md** — how to operate (these rules). Stable.
- **CONTEXT.md** — what the domain words mean and how they relate. Grows; owned by `wiki-onboard`.
- **wiki/index.md** — the live map of sections (the information architecture).

These conventions are canonical: the skills state their own procedure and defer to this file for the shared rules below.

`PROFILE.md` is not one of them — it is **setup input**, not a standing document. A vault ships with the kickoff pack from the interview that preceded it; `wiki-onboard` reads it to draft the wiki, then files it into `sources/` as a `#source/kickoff` note so its facts get distilled with provenance. After onboarding the root no longer holds it. Its format is `.claude/skills/wiki-onboard/references/profile-format.md`.

## Provenance

Every claim in the wiki traces back to the raw material it came from. This is the invariant the vault exists to protect, and the reason a wiki page is worth more than the transcript it came from.

- **Sources are the archive** — append-only. You never edit a source's raw content. The only changes are the status flag (`#status/pending` → `#status/distilled`, by distill) and guidance the *user* adds in the callout.
- **A source can be deleted only while nothing cites it** — that is, while it is still `#status/pending`. Once distilled, wiki claims point at it and removing it would break provenance, so it stays forever. This is the undo for a bulk ingest that pulled in junk. Deletion is always the **user's** call: you propose, they approve, and you never delete on your own initiative.
- **Every claim cites its source**, inline, with a wikilink at the end of the claim: `Headcount is roughly 240. [[acme-call-2026-08-01]]`. A fact you can't attribute belongs in `wiki/maintenance/open-questions.md`, not on a page.
- **Superseded claims keep their history** — when a newer source changes a fact, the old claim moves to a dated child bullet beneath the live one.

Where a skill says *preserve provenance*, it means this section.

If the wiki has not been set up yet (`CONTEXT.md` or source templates missing), use `.claude/skills/wiki-onboard/SKILL.md` first.

**The session-start nudges**: `.claude/settings.json` runs two `SessionStart` hooks, so their output lands in your context at the top of every session. Each is silent when it has nothing to say, and neither is a licence to start work — raise what it reports with the user early, and act only if they ask.

- `.claude/hooks/wiki-backlog-check.sh` counts what is waiting — source notes still tagged `#status/pending` and unresolved items in `wiki/maintenance/open-questions.md` — and prints a line when either is above zero. Offer to distill; never start distilling off the nudge alone.
- `.claude/hooks/wiki-onboarding-resume.sh` reports an onboarding that stopped part-way, reading `meta/onboarding-progress.md`: the stages left and the next step the last session recorded. Offer to resume `wiki-onboard`.

## Obsidian-native markup (always)

- **Tags** carry facets you filter by: source type (`#source/transcript`) and status (`#status/pending`).
- **Properties** (frontmatter) carry attributes with a value: `submitted_by`, `captured_at`, `source_date`, and any type-specific extras.
- **Wikilinks** carry every citation and cross-reference: `[[acme-call-2026-06-08]]`. They give backlinks both ways.
- **Aliases** (`aliases:`) on entity pages let mentions auto-link ("Acme", "Acme Corp" → one page). Keep them precise — never single generic words.

## Sources

Sources are fetched into the vault (by `wiki-ingest`) or clipped (Web Clipper); users rarely create them by hand. Every source note has the common base plus the type's extras, a guidance callout, and the raw content:

```md
---
submitted_by:        # who added / fetched it
captured_at:         # when it was added (today)
source_date:         # when the source itself is from
tags:
  - source/<type>
  - status/pending
# + per-type extras (see "Source types" below)
---

> [!note] Distill guidance (optional)
> The user may add steering for distill here — what to emphasize, where to file,
> what to ignore. Keep the callout even when empty.

## Source

(raw content — never edited by Claude)
```

Web articles arrive via the Obsidian Web Clipper into `sources/clippings/`, already carrying the header. Sources are the archive — see **Provenance**.

### Source types

`wiki-onboard` records each source type and its extra properties here — this table is the schema `wiki-ingest` fills in. Until then, the common base applies to all. A type's own date is always `source_date`; extras carry only what the base doesn't. Example:

| Type | Tag | Extra properties |
|------|-----|------------------|
| kickoff | `#source/kickoff` | company, role, status |
| email | `#source/email` | from, to, thread |
| transcript | `#source/transcript` | attendees |
| web-clip | `#source/web-clip` | url, site |

`kickoff` ships with the template and always applies — it is the interview pack the vault arrived with, filed by `wiki-onboard`. Its `status` property is interview completeness (`complete` / `partial`), unrelated to the `#status/` tag.

## Wiki

- Compile knowledge into **designed sections** (`wiki/<section>/`), not a generic bucket. Sections are a deliberate information architecture defined at onboarding — informed by `CONTEXT.md`, not a 1:1 list of every term.
- **Progressive disclosure**: `wiki/index.md` links only to first-level sections. Every directory under `wiki/` has its own `index.md`. When creating a section, create its `index.md` first and add it to the parent index.
- **Entity-centric**: distilled facts fold into entity pages (e.g. `wiki/customers/acme-corp.md`), built from many sources over time.
- **Index links are path-qualified** — every directory has an `index.md`, so link them as `[[meetings/index|Meetings]]`; a bare `[[index]]` is ambiguous.
- **Meetings** also get a short notes page in `wiki/meetings/` — the one source-shaped page type.
- Put conflicting claims in `wiki/maintenance/contradictions.md`. Put unresolved follow-ups, suggested new pages, and suggested new terms in `wiki/maintenance/open-questions.md`.


## Ownership

- **Humans own structure** — `CONTEXT.md` and the section list change only via `wiki-onboard`. Distill never invents a section or edits `CONTEXT.md`; it routes those to `open-questions.md`.
- **Claude owns content and bookkeeping** — distilling sources, writing pages, maintaining links and indexes.

## Operations

The user states what they want; you pick the operation. They know their work, not the skill names — a request that means one of these fires it, however it is worded.

- **Ingest** — the user wants outside material in the vault ("grab today's emails", "that call just finished"); run `wiki-ingest` to fetch it from their tools and file it in `sources/` as `#status/pending`. (Web Clipper handles web articles into `sources/clippings/`.) Capture leaves the wiki untouched; the user may add a guidance note to any source before distilling.
- **Distill** — the user wants what's been captured turned into wiki knowledge; run `wiki-distill` over all `#status/pending` sources.
- **Capture the session** — the user wants what this conversation settled written into the wiki ("save what we decided", "get this in before we finish"); run `wiki-session-capture`. It writes to `wiki/` directly — a session leaves no note in `sources/`, so its claims carry no citation. This is the one operation you may also raise yourself — see **the finding nudge** below.
- **Onboard** — the user wants to start the wiki, or its sections no longer fit how they work; run `wiki-onboard`. It drafts the wiki from `PROFILE.md` where one is present, so the user is asked only about what their kickoff interview left open.
- **Lint** — the user wants the wiki checked over or tidied; run `wiki-lint` to fix safe bookkeeping and route judgment calls to the maintenance files. Owns content + bookkeeping, never structure.
- **Query** — the user asks a question; read `wiki/index.md`, drill into pages, answer with citations.
- **Help** — the user asks where to start, what this is, or what to do next ("how does this work?", "what now?", "am I using this right?"); run `wiki-help`. It reads the vault's state and offers the next move; it never acts on its own. Distinguish it from **Query**: help is a question about the *vault*, query is a question about their *domain*.

**The finding nudge**: the session-start hook watches material waiting in `sources/`; nothing watches the conversation itself, so that part is yours. When a session settles something the wiki would want — a decision the user made, a domain fact they stated, a constraint that shaped the work, a term they chose — say so once, name in a line or two what you would capture, and offer to run `wiki-session-capture`. Judge *settled* exactly as that skill does: the user stated it, chose between options, or confirmed a proposal of yours. A proposal they never answered settles nothing, and neither does your own analysis.

Hold the offer to **once per session**, at a natural pause rather than mid-task, and never capture unasked. A second offer is nagging; if they decline or ignore it, drop it — they can ask in their own words whenever they want.

Append meaningful passes to `meta/maintenance-log.md` (`YYYY-MM-DD · who · what`).


## Communication
- Keep language succinct and focused. Avoid large block text and lingo.
- **Speak the user's domain, never the wiki's.** The user makes no knowledge-base decisions — property names, tags, statuses, filing choices, and page mechanics are yours to decide silently. When a gap genuinely needs them, translate it into a question about their world: ask *"Who runs the Acme account?"*, never *"`owner` is empty on 6 pages"*; ask *"Is this worth keeping track of here?"*, never *"I logged it in open-questions as a suggested page"*. A question you can't phrase in their domain words isn't theirs to answer.
