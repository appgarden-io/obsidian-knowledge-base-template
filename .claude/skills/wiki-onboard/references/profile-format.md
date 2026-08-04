# The kickoff pack (`PROFILE.md`)

A **kickoff pack** is the markdown artefact an AppGarden kickoff interview
produces: one person, interviewed about their role and how their part of the
business works, written up in their own words. It ships in the vault's zip as
`PROFILE.md` at the root.

`wiki-onboard` reads it first, derives a draft wiki from it, and only interviews
the user about what the pack could not settle. This file is the contract: the
pack's shape, what each part drives, and what to do when it is thin or missing.

## Shape

```md
---
submitted_by: Gavin Reubenson   # who answered
captured_at: 2026-08-03         # when the interview ran
source_date: 2026-08-03
company: Paycorp
website: paycorp.co.za        # optional — present when the interview asked for it
role: Group CIO
status: complete                # complete | partial — how far the interview got
tags:
  - source/kickoff
  - status/pending
---

# Kickoff Pack — <Company> — <Their Name>

## 1. Their role
## 2. Their part of the business
## 3. Team structure
## 4. Core processes
## 5. Data sources and systems of record
## 6. Conversations
## 7. Current tooling
## 8. AI use (including Cowork)

## Their words          # **Term**: definition. _Also called_: … _Ambiguous_: …
## Systems of record    # | System | What lives in it | Who owns it | Source of truth |
## Their grouping       # their own clusters, ungrouped by us
## Anything else
## Gaps                 # what was not covered, and what stayed vague

---

## Appendix — full Q&A
```

The numbered sections carry free prose; longer packs add `###` subheadings
inside them. Treat the eight numbered headings, `Their words`, `Systems of
record`, `Their grouping` and `Gaps` as the parts you can rely on — everything
else is optional.

Note the two different `status`es: the **property** `status: complete | partial`
is how far the interview got; the **tag** `#status/pending` is the vault's
distill flag. They are unrelated.

## Where it arrives

- Canonically `PROFILE.md` at the vault root.
- Several people may have been interviewed for one company. Then the packs
  arrive in `profile/` at the root, one file per person — read all of them.
- Packs get emailed around, so one may land as `.txt`, `.docx` or `.pdf`, or as
  UTF-16 rather than UTF-8. Read it anyway; the headings are what matter.

## What each part drives

The pack is **design input, not a decision**. Nothing here becomes structure
until the user approves it at the skill's step 3 gate.

| Pack part | What it settles |
|---|---|
| `company`, `role`, `submitted_by` | Who the vault is for. `company` names `CONTEXT.md`; `submitted_by` is the default for sources this person adds. |
| 1. Their role | The wiki's **scope boundary** — which of their areas the vault has to cover, and which are somebody else's problem. |
| 2. Their part of the business | Entities: business lines, entities, countries, customer types. Candidate entity sections. |
| 3. Team structure | Teams, managers, ownership. A candidate section, and the owner field on system and process pages. |
| 4. Core processes | One candidate page per named process, with the steps they gave. |
| 5. + `Systems of record` | One candidate entity page per system, carrying what lives in it, who owns it, and whether it is the truth. |
| 6. Conversations | Which **source types** are real. "Meetings are recorded and transcribed" earns `#source/transcript`; "a fair amount of email" earns `#source/email`; face-to-face that is never written down earns nothing. |
| 7. Current tooling | Where material will be fetched from, and so what `wiki-ingest` should expect. |
| 8. AI use | Not structural. Note it in the maintenance log and move on. |
| `Their words` | `CONTEXT.md` Language, near-verbatim. `_Also called_` → `_Avoid_`. `_Ambiguous_` → a question for the grill. |
| `Their grouping` | **The primary input to section design.** Their own clusters, in their words. |
| `Anything else` | Whatever it fits. |
| `Gaps` | Seeds `wiki/maintenance/open-questions.md`, and sets the grill agenda. |
| Appendix — full Q&A | Never mined for structure. It rides along in the filed source, for `wiki-distill`. |

**`Their grouping` outranks your own taxonomy.** When a tidier information
architecture suggests itself, propose it at the step 3 gate as the alternative
and let the user pick.

## The grill list

What the pack cannot settle, and so what the step 3 gate is *for*. Distinct from
the pack's own `## Gaps`, which is one input to this list rather than the whole
of it. Everything outside these five goes to `open-questions.md` instead of
becoming a question.

1. **Section design.** The pack gives clusters, never a folder list — and a
   cluster becomes a folder only by clearing the skill's three-justification bar.
   Their grouping is the input to that test, not a pass through it.
2. **Ambiguous terms.** Every `_Ambiguous_` note in `Their words` is unresolved
   by construction.
3. **Structural `Gaps`.** A `Gaps` entry earns a question when it would change
   the section list — a whole business line nobody explored, say. A gap that is
   merely missing content is an open question, not an interview question.
4. **Entity or section?** A term dense enough to be either. It is a section only
   with three real pages behind it today; otherwise it is one page.
5. **Source reality.** The pack says how they talk, not what will actually land
   in `sources/`.

## Several packs

Read them all before proposing anything.

- **`Their words`** — take the union. Where two people define the same term
  differently, that is a real contradiction: log it in
  `wiki/maintenance/contradictions.md`, citing both packs, and ask about it.
- **Spelling variants of one thing** (Postilion / Positilion) are not
  contradictions — pick the form the system's owner used and list the other
  under `_Avoid_`.
- **`Their grouping`** — sections must serve every interviewee, not just the
  most senior. Where one person's clusters would strand another's work, say so
  when you propose.
- **`Systems of record`** — merge into one table; where owners disagree, prefer
  the pack whose author owns the system.

## No pack

The skill still works. Run the full interview described in its step 1 fallback —
the pack is an accelerator, never a prerequisite.
