# Progress log

`meta/onboarding-progress.md` is the working state of an onboarding run: the stage
checklist, every confirmation the user has given, and the one next move. It is what
makes stopping safe — `.claude/hooks/wiki-onboarding-resume.sh` reads it at session
start, so a later session opens already knowing where the last one stopped.

Claude maintains it. The user never edits it, and never needs to know it exists —
to them, stopping mid-run just works.

## Shape

Create it the moment the user gives their go-ahead in stage 0:

```md
---
started: YYYY-MM-DD
status: in-progress
---

# Onboarding progress

Working state for `wiki-onboard`. Claude maintains this; the user never edits it.

- [ ] 0 · Introduced the session
- [ ] 1 · Domain understood → `CONTEXT.md`
- [ ] 2 · Sections created → `wiki/<section>/`
- [ ] 3 · Kickoff pack distilled
- [ ] 4 · Source types settled · backfill run
- [ ] 5 · Backfill distilled
- [ ] 6 · Handed over

## Confirmed with the user

(what they have settled — section names, source types, terms they corrected you on)

## Next step

(the one thing a fresh session should do first)
```

Keep the stage list exactly as above — the resume hook counts those checkboxes.

## When to write

Two moments, **always before your next message to the user**:

- **On every confirmation** — the instant they settle something you would otherwise
  have to ask twice: the section tree in stage 2, the source types in stage 4, a term
  they corrected in stage 1. Stage-boundary writes alone are not enough; a grill that
  dies mid-stage must not cost them the answers they already gave.
- **On every stage boundary** — tick the box, rewrite `## Next step`.

The vault records the rest — folders that exist, templates that exist, `#status/`
tags. This file holds only what the filesystem can't show.

## Resuming from it

The file says where the last session *thought* it got to; the vault says what
actually landed.

- **Check a tick against the vault before trusting it.** If it claims stage 2 but
  the section folders aren't there, that stage didn't finish.
- **Where the two disagree, the vault wins** — correct the file, then carry on from
  the first stage that genuinely isn't done.
- **Read `## Confirmed with the user` before asking anything.** Re-asking a question
  they already answered is the failure this file exists to prevent.
- **`status: complete` is a finished run, not a resume.** Start fresh over the file
  with today's `started:` date.

## Closing it out

At stage 6, tick the last box and set `status: complete`. That is what silences the
resume nudge — leave it `in-progress` and every future session opens by offering to
finish a run that is already done.
