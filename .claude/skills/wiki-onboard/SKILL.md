---
name: wiki-onboard
description: >
  Onboard a personal Obsidian wiki from the kickoff pack in `PROFILE.md` for the person specified.
---

# Wiki Onboard

Shape a blank template into *this person's* knowledge base. The user has usually already sat
through a kickoff interview captured in `PROFILE.md`.

This skill owns **structure** — `CONTEXT.md`, the section folders, the source
schemata and the creation of standardised Obsidian file properties.

Record the completion of each stage in `meta/maintenance-log.md` so the user can pickup from where they left if starting a new session.

## Flow

### 0. Introduce the session

Open a fresh onboarding with the script in
[references/introduction.md](references/introduction.md), copied word for word,
and wait for the user's go-ahead. On a resume — the log already shows completed
stages — skip the script and pick up from where the log leaves off.

### 1. Understand the domain → `CONTEXT.md`

Start by building out `CONTEXT.md`.
- Look at `PROFILE.md` and begin grilling the user on terminology and concepts that are not clear. Use the AskQuestion tool if relevant, avoid Obsidian lingo, knowledge base lingo or advanced Claude lingo. Once you beleive you have a grasp of a concept, explain it back to the user and ask if you understand it correctly. If the answer is yes, persist to `CONTEXT.md`. If the answer is no, ask for missing information.
- Use format from [../domain-modeling/CONTEXT-FORMAT.md](../domain-modeling/CONTEXT-FORMAT.md).
- **Every gap the pack leaves is asked here, in the grill** — an unclear term, a
  missing owner, an ambiguous spelling, a process you can't picture. The user is
  sitting right there; ask them now. Never file an interview gap into
  `wiki/maintenance/open-questions.md` — that file is for what *distill* can't
  resolve later, not for questions you could have asked during setup. If the
  user genuinely doesn't know or doesn't care, drop it.
- **Done when** every term from `Their words` appears there, in the user's own
wording rather than a cleaner phrasing of yours, and no question about the pack
remains unasked. Onboarding ends with zero open questions.

### 2. Create the directory structure → `wiki/<section>/`

Suggest a folder structure for the vault using ascii tree. Explain what each
section will house. Aim for 4-6 main, root level folders. Iterate until the user
confirms they are satisfied with the structure.

The moment they confirm, name the next step so there is no ambiguity about
where this is going. Say this word for word:

> Now we are going to bootstrap your knowledge base with relevant data to get
> you started. This may use a large amount of tokens so make sure your model
> is set to Sonnet High.

Then wait for their go-ahead — the model switch is theirs to make, and
everything from here on (building sections, the kickoff distill, the backfill)
is the token-heavy part.

On the go-ahead, build what they confirmed:

1. Create each `wiki/<section>/` folder and its `index.md`.
2. Link every section from the root `wiki/index.md`, path-qualified
   (`[[customers/index|Customers]]`).
3. In the index.md, outline the available Obsidian properties that should be used when persiting md files to the section. Refer to the `obsidian-markdown` skill.

**Done when** every section has an `index.md`, each linked from `wiki/index.md`.

### 3. Distill the kickoff pack

The pack becomes the vault's first source, and its facts the first wiki pages —
so the user sees real pages appear before any external data is touched.

1. **File it** — move `PROFILE.md` into `sources/` as a `#source/kickoff` note:
   the header schema from `sources/_template-kickoff.md`, the pack's body
   verbatim under `## Source`, and `#status/pending`. The root no longer holds
   `PROFILE.md` after this.
2. **Distill it** — run `wiki-distill`
   ([../wiki-distill/SKILL.md](../wiki-distill/SKILL.md)) over that one source.
   Its facts fold into the sections built in stage 2, every claim citing the
   kickoff note. The grill already settled the pack's gaps, so this distill
   should raise no new questions.

**Done when** `PROFILE.md` is gone from the root, the kickoff note is
`#status/distilled`, and its facts sit on wiki pages with citations.

### 4. Bootstrap external data

The wiki now holds what the pack knew; this stage brings in what their systems
know.

1. **Settle the source types** — ask the user to confirm which data sources they
   plan to ingest information from. Write a `sources/_template-<type>.md` per
   type with `source/<type>` filled in and that type's extras added — the extras
   being only what the common base doesn't already carry (a source's own date is
   always `source_date`). Record the per-type schema in the table in
   `CLAUDE.md`, so `wiki-ingest` and `wiki-distill` can rely on it.
2. **Backfill** — run [references/backfill.md](references/backfill.md) directly
**Done when** every data source type named has both a template file and a row in
the table, and the backfill has run.

### 5. Distill the backfill

What the backfill landed is raw material; this turns it into wiki pages. Run
`wiki-distill` over the `#status/pending` sources the backfill wrote. If the
batch is large, distill a first slice so the user sees pages appear before
deciding on the rest.

**Done when** the backfilled sources are distilled, or the user has stopped
after a slice they're happy with.

### 6. Hand over

Close by running `wiki-help` ([../wiki-help/SKILL.md](../wiki-help/SKILL.md)).
The user has just answered a run of questions and owns a vault they have never
used, so end on where they are and the one or two things worth doing next —
not on a summary of what you built. `wiki-help` reads the state you just
created, so it says the right thing however far they got.

The close is an **offer to act, not a goodbye**:

- If a stage was declined it is the first move to offer — the backfill, or the
  distill of what it landed. Both run here, in this session.
- If everything ran, point at the loop from here: new material arrives through
  ordinary capture (`wiki-ingest`), and distill turns it into pages.
- No fresh-session advice, ever — nothing about this vault needs a restart.
- No reopening structure — stage 2 already gated on it. Don't close with
  "anything you'd change?"; if a term is wrong they'll say so unprompted.

**Done when** the user has either taken the next move or declined it.

## Guardrails

- **Discover before you create** — where `CONTEXT.md`, sections, or templates
  already exist, extend them, and confirm with the user before changing what's
  there.
- **You write the YAML** — the user answers questions; the templates are yours to
  author.
- **The domain model stays supervised** — `wiki-distill` and `wiki-lint` only
  *suggest* terms and sections, into `open-questions.md`. Folding a suggestion in
  means re-running this skill.
