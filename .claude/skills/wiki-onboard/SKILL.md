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

### 1. Read the pack

Start by building out `CONTEXT.md`. 
- Look at `PROFILE.md` and begin grilling the user on terminology and concepts that are not clear. Use the AskQuestion tool if relevant, avoid Obsidian lingo, knowledge base lingo or advanced Claude lingo. Once you beleive you have a grasp of a concept, explain it back to the user and ask if you understand it correctly. If the answer is yes, persist to `CONTEXT.md`. If the answer is no, ask for missing information.
- Use format from [../grill-with-docs/CONTEXT-FORMAT.md](../grill-with-docs/CONTEXT-FORMAT.md).
- **Done when** every term from `Their words` appears there, in the user's own
wording rather than a cleaner phrasing of yours.

### 2. Gate: propose, then grill what's open

Next, suggest a folder structure for the vault using ascii tree. Explain what each section will house. Aim for 4-6 main, root level folders. Move to next section once user confirms they are satisfied with structure. Iterate until they are satsfied.

### 3. Build the sections → `wiki/<section>/`

1. Create each `wiki/<section>/` folder and its `index.md`.
2. Link every section from the root `wiki/index.md`, path-qualified
   (`[[customers/index|Customers]]`).
3. In the index.md, outline the available Obsidian properties that should be used when persiting md files to the section. Refer to the `obsidian-markdown` skill.

**Done when** every section has an `index.md`, each linked from `wiki/index.md`.

### 4. Create source property templates

Ask the user to confirm which data sources they plan to ingest information from. Once settled, write a `sources/_template-<type>.md` per type with `source/<type>` filled in and that type's
extras added — the extras being only what the common base doesn't already carry
(a source's own date is always `source_date`).

Record the per-type schema in a table in `CLAUDE.md`, so
`wiki-ingest` and `wiki-distill` can rely on it.

**Done when** every data soruce type named has both a template file and a row in
the table.


### 5. Connect their systems and backfill

The knowledge base is now shaped but empty. Offer to fill it. Encourage the user to start a new session and when they do, to mention 'I want to backfill the knowledge base'. See [references/backfill.md](references/backfill.md)

The user can decline or come back later. Say so, and note it in the log.

### 6. Hand over

Close by running `wiki-help` ([../wiki-help/SKILL.md](../wiki-help/SKILL.md)).
The user has just answered a run of questions and owns a vault they have never
used, so end on where they are and the one or two things worth doing next —
not on a summary of what you built. `wiki-help` reads the state you just
created, so it says the right thing whether or not they took the backfill.

**Done when** the user knows their next move.

## Guardrails

- **Discover before you create** — where `CONTEXT.md`, sections, or templates
  already exist, extend them, and confirm with the user before changing what's
  there.
- **You write the YAML** — the user answers questions; the templates are yours to
  author.
- **The domain model stays supervised** — `wiki-distill` and `wiki-lint` only
  *suggest* terms and sections, into `open-questions.md`. Folding a suggestion in
  means re-running this skill.
