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

The user is not technical and did not build this vault. Answer one question:
what is worth doing next? Three checks, then a short offer.

**This skill changes nothing.** No file written, no source touched, no page
created, no status flipped. You offer; they answer.

## The three checks

Run all three (Glob, Grep, Read — nothing else), then offer what matches.

**1. Are they onboarded?** — does `CONTEXT.md` exist at the root?

- **No** → this is the only thing worth doing. Offer to set the wiki up
  (`wiki-onboard`). A `PROFILE.md` still at the root means their kickoff
  interview is already in the vault, so say that — it makes setup short. Stop
  here; the other two checks don't matter yet.
- **Yes** → the wiki is ready to feed. Offer both ways in:
  - bring outside material in — email, a call that just ended, a doc someone
    shared (`wiki-ingest`)
  - think an idea through with you and keep what it settles
    (`wiki-session-capture`)

**2. Is anything waiting?** — sources tagged `#status/pending` (skip
`_template-*.md`). If there are several, offer to distill them into the wiki
(`wiki-distill`), with the count.

**3. Any open questions?** — real bullets in `wiki/maintenance/open-questions.md`.
If there are, name a couple and ask whether they want to resolve any.

> The maintenance files ship with placeholders — `No open questions yet.`,
> `None yet.`, `No contradictions recorded yet.` Those are not open questions.

## Say it back

A few lines, no more:

- **Where it is** — one sentence with the numbers: *"6 pages, 2 sources
  waiting, 3 open questions."* Numbers, not adjectives.
- **What's next** — the moves the checks turned up, each written as something
  they could say out loud: *"catch the wiki up"*, *"grab today's emails"*.
  There are no magic words in this vault — these are examples, not commands.

On the first run after onboarding, add the loop in three words so the shape is
obvious: **capture → distill → ask**. Skip it afterwards; they know by then.

Then stop and let them answer. An offer they ignore is an answer.

## Guardrails

- **Read-only** — this is the one skill that only reads. If something looks
  broken, name it and offer `wiki-lint`; don't fix it here.
- **Their words, not the skill names** — name a skill only in parentheses, if
  at all.
- **Don't tour the vault** — no section-by-section walkthrough, no inventory.
  Depth is what the wiki itself is for.
- **A fresh vault is not a neglected one** — onboarding seeds
  `open-questions.md` with the gaps the kickoff pack left. That is the system
  working.
