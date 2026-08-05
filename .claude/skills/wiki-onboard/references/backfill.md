# First backfill

Onboarding ends with an empty vault. This is how it gets filled: connect the
user's systems of record, point at the directories their work lives in, and pull
a first body of material into `sources/`.

It runs **once**, at the end of `wiki-onboard`, after `CONTEXT.md` and the
sections exist — because the glossary is what tells junk from signal. Day-to-day
capture afterwards is `wiki-ingest`'s job.

## The problem this solves

A backfill is not a fetch. "Ingest my Drive" can mean four thousand files, most
of them irrelevant, some of them nobody's business. So the user decides **before**
anything is written, in batches they can see, and the archive commit comes last.

Four beats: **survey → plan → sample → ingest**, then prune. Three of the joins
are **gates** — the plan, the sample, the prune — where the user decides and you
wait. Work only up to the next gate.

## 0. Ask for the data sources

1. Ask the user to attach any folders that houses documents and work that would be relevant to ingest into this  knowledge base.
2. Confirm known data sources with the user and ask them to connect them via the Claude Connector store.
3. Ask the user to confirm when the connectors have been connected, and validate by running a simple query to check that the connectors are active. 


1. **Systems of record** — Confirm known data sources with the user and ask whether it is
   reachable from here. For each, discover whether a connector exists in this
   session (see `wiki-ingest`'s connector table). Where one is missing, name it
   and say how to connect it — then move on; a missing connector is a gap to
   report, not a blocker. If a user mantains they added a connector but you still can't see it, reload plugins so it appears in the session.
2. **Directories** — ask for the folders their own work lives in. Paths, or an
   attached directory. Ask what is in each in one line.

Record any system you could not reach in `wiki/maintenance/open-questions.md`
under `## Questions`, so it resurfaces rather than being silently dropped.

## 1. Survey — read and report

A survey reads and reports; the first thing to land in `sources/` lands at step
3, from a batch the user has approved. Enumerate each connected source and each directory, and report, per source:

- how many items, and over what date range
- the breakdown by file type
- the largest items, and anything that is plainly not text
- the top folders by item count

**Done when** the user can see the shape of everything they pointed you at.

## 2. Gate: the plan — one file the user edits

Write `meta/ingest-plan.md`. This is the collaboration surface: a checklist beats
forty yes/no questions, and it leaves a record of what was decided.

```md
# Ingest plan

Tick what to bring in. Edit the globs and the cutoff. Nothing is ingested until
you say go.

## Batches

- [ ] **Board decks** — `~/work/board/**/*.pdf` — 34 items, 2024-01 → 2026-07
- [ ] **Customer email** — Gmail, `label:customers` — ~1,200 items
- [x] **Meeting transcripts** — Zoom, last 6 months — 88 items
- [ ] **Old shared drive** — `~/work/archive/**` — 3,400 items ⚠ large

## Rules

- Cutoff: nothing older than 2024-01-01
- Exclude: `**/personal/**`, `**/payroll/**`, `*.key`, `*.env`
- Cap: 200 sources per pass
```

Fill in real counts from the survey. Flag any batch over the cap with ⚠ and say
what you would drop. Ask for confirmation via the AskQuestion multi-select. Then hold the gate: the user answers, and you wait.

## 3. Gate: the sample — 2 or 3, then ask

For each ticked batch, ingest **two or three items** as real source notes, in the
shape `CLAUDE.md` specifies, and show them to the user.

Ask one question: *more like this, or drop the batch?* Adjust the globs from what
they say and re-sample if the answer was "sort of".

**Done when** every ticked batch has been approved or dropped by name.

## 4. Ingest the batch

Write the batch as normal source notes — `wiki-ingest`'s step 4 rules apply, and
`CLAUDE.md` holds the header schema. Beyond those:

- **Relevance filter** — a candidate earns a source note when it mentions a term
  or entity from `CONTEXT.md`. This is the junk filter, and it is explainable:
  when the user asks why something was skipped, you can say which terms it
  missed. Report the count you filtered out.
- **Volume cap** — respect the cap in the plan. When a batch exceeds it, ingest
  the most recent up to the cap and **say plainly** what you left, so a truncated
  pass never reads as a complete one.
- **Sensitivity screen** — skip anything matching the plan's excludes, plus
  credentials, payroll, HR files about named individuals, and personal material.
  List what you skipped by name so the user can overrule you. Never ingest a
  file whose sensitivity you are unsure of; ask.
- **Large and binary items** — a 200-page PDF or a spreadsheet does not go into
  a note verbatim. Write the source note with the full header, an extracted text
  summary, and a path or URL pointer to the original under `## Source`. Say in
  the note that it is a pointer, not the whole item.
- **Dedup** — the same document lives in three folders under three names. Check
  title and `source_date` together, not the file name alone, and prefer the copy
  in the most specific location.

## 5. Gate: the prune

Everything from a backfill is `#status/pending`, so nothing cites it yet — and a
source nothing cites can be deleted. That is
the undo, and the window closes the moment a source turns `#status/distilled`.

Show the user what landed and offer to drop any of it. You propose, they approve.

## Delegating to subagents

A backfill is read-heavy: thousands of file names, long PDFs, whole mailboxes.
Pulling that through one context is what makes a backfill fail — you run out of
room before the user has decided anything. Push the reading out to haiku subagents and
keep only their summaries.

If your agent tool has no subagents, run the same beats inline, one at a time.
The sequence is what matters, not the parallelism.

**Fan out:**

- **Survey** — one agent per system and per directory. Read-only. Each returns
  counts, date range, type breakdown, top folders and largest items.
- **Heavy extraction** — one agent per oversized or binary item. It reads the
  PDF or the spreadsheet so the main thread never has to, and returns the summary
  and pointer that go in the note.
- **Relevance triage** — for a large batch, one agent per chunk of candidates.
  Each returns keep/drop per item **with the `CONTEXT.md` terms that matched**,
  so the filter stays explainable.
- **Batch ingest** — one agent per approved batch, writing that batch's source
  notes.

**The gates stay in the main thread**, along with anything structural — an agent
cannot hold a conversation with the user.

**Rules for every agent you spawn:**

- **Return a summary, never the content.**
- **Read `CLAUDE.md` and `CONTEXT.md` first** — it does not share your context,
  and the header schema and the glossary are what it needs.
- **One namespace each** — one system, one directory, one batch. Two agents must
  never be able to write the same source note.
- **No agent talks to the user.** Anything unclear — a file it can't classify,
  a folder that looks sensitive — comes back in its report, and you ask.
- **Report skips by name**, so filtered and sensitive items stay visible.

A batch whose agent dies leaves a partial batch, which is recoverable: everything
is `#status/pending`, and the dedup check catches the overlap when you re-run it.
Say that it failed rather than silently retrying.

## 6. Hand over

Report: what was ingested per batch, what was filtered and why, what was skipped
as sensitive, what was capped, and which connectors were missing.

Then tell the user the two things that follow — **distill** turns this into wiki
pages, and from here on new material arrives through ordinary capture, a batch at
a time, not a backfill. Encourage the user to run the distill skill in a fresh session.
