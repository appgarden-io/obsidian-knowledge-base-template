---
name: wiki-help
description: >
  Orient the user in their Obsidian company wiki: work out what state the vault
  is in and tell them what is worth doing next. Use when the user asks for help
  or a tour — "what do I do now", "how does this work", "what's in here", "where
  do I start", "am I using this right" — and at the end of every `wiki-onboard`
  run. Read-only: it explains and offers, and changes nothing.
---

# Wiki Help

The user is not technical and did not build this vault. Work out where the wiki
actually is, say so in one line, and hand them the two or three things worth
doing next — phrased as things they could say, not skill names.

**This skill changes nothing.** No file written, no source touched, no page
created, no status flipped. Where the answer is "distill what's waiting", you
*offer* and wait for a yes.

## 1. Read the state

Eight cheap checks from the vault root — Glob, Grep, Read, nothing else:

| # | Signal | How to read it |
|---|--------|----------------|
| 1 | Onboarded | `CONTEXT.md` exists at the root |
| 2 | Onboarding finished | no `PROFILE.md` left at the root, and `sources/_template-*.md` exist |
| 3 | Sections | first-level directories under `wiki/`, `meetings/` and `maintenance/` aside |
| 4 | Pages | `.md` files inside those sections, not counting `index.md` |
| 5 | Waiting | sources tagged `#status/pending` (skip `_template-*.md`) |
| 6 | Distilled | sources tagged `#status/distilled` |
| 7 | Loose ends | real bullets in `open-questions.md` and `contradictions.md` |
| 8 | Last pass | the final line of `meta/maintenance-log.md` |

**Check 7 has a trap.** Both files ship with placeholder bullets, and they are
worded differently in each: `No open questions yet.`, `None yet.` (three of
them, one per heading), and `No contradictions recorded yet.`. Count a bullet
only when it is none of those — otherwise you report a contradiction in a vault
that has never been used.

## 2. Name the state

Walk the ladder top to bottom and stop at the **first** rung that matches. That
one is the headline and its move is what you offer. Rungs below it that also
match get a single line each, no more.

| State | Matches when | The move |
|---|---|---|
| **Not set up** | no `CONTEXT.md` | Set the wiki up (`wiki-onboard`). A `PROFILE.md` at the root means their kickoff interview is already in the vault, so say that — it makes the setup short. |
| **Half set up** | `CONTEXT.md` exists, but `PROFILE.md` is still at the root or the source templates are missing | Onboarding stopped partway. Finishing it (`wiki-onboard`) files the pack into `sources/` and writes the templates. |
| **Empty** | onboarded, no pages, nothing waiting | Shaped but holding nothing. Get material in — connect the tools they named and backfill, or hand you something directly (`wiki-ingest`). |
| **Waiting** | anything is tagged `#status/pending` | Material has landed but is not knowledge yet. Distill it (`wiki-distill`). |
| **Drifting** | any contradiction, or more than ten open questions, or the last log line is over a month old | Loose ends are outgrowing the wiki. Check it over (`wiki-lint`) and work through the open questions. |
| **Working** | pages exist and nothing is pending | It is doing its job. Say what it holds, and what to say to keep it fed. |

## 3. Say it back

One screen, three parts:

- **Where it is** — one sentence carrying the numbers: *"6 pages across 3
  sections, 2 sources waiting, last distilled 12 July."* Numbers, not adjectives.
- **What's next** — two or three moves, each written as something they could say
  out loud: *"catch the wiki up"*, *"grab today's emails"*, *"what do we know
  about Acme?"*. There are no magic words in this vault — these are examples of
  the idea, not commands to type.
- **What only they can do** — one line, when it applies. Sections and the domain
  language are theirs (`CLAUDE.md`, **Ownership**); you suggest those into
  `open-questions.md` and wait.

On the first run after onboarding, add the loop in three words so the shape is
obvious: **capture → distill → ask**. Skip it afterwards; they know by then.

Then stop and let them answer. An offer they ignore is an answer.

## Guardrails

- **Read-only** — this is the one skill that only reads. If a check turns up
  something broken, name it and offer `wiki-lint`; don't fix it here.
- **Their words, not the skill names** — the user knows their work, not the
  skills. Name a skill only in parentheses, if at all.
- **Numbers, not adjectives** — "2 sources waiting" beats "a small backlog", and
  a count they can check keeps you honest.
- **Don't tour an empty vault** — with no pages, describing sections that hold
  nothing reads as busywork. Say it's empty and get to how to fill it.
- **A fresh vault is not a drifting one** — onboarding seeds `open-questions.md`
  with the gaps the kickoff pack left. That is the system working, so don't read
  a pile of day-one questions as neglect.
- **One screen** — help that needs scrolling is not help. Depth is what the
  wiki itself is for.
