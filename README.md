# Obsidian Company Wiki Template

A minimal template for a Claude-maintained company wiki in Obsidian. You feed in raw material — emails, meeting transcripts, documents, web clips — and Claude distills it into linked wiki pages and keeps everything consistent.

```text
        raw material you add
                 |
                 v
   sources/   (flat · tagged by type · #status/pending)
                 |
        "distill"  ->  Claude (wiki-distill)
                 |
                 v
   wiki/<section>/pages   (facts folded in, each linked back to its source)
```

## Start

1. Open this folder as an Obsidian vault, and open it in Claude Code.
2. Ask Claude to **set up your wiki** (it runs the `wiki-onboard` skill). If your kickoff interview shipped with this vault, it's the `PROFILE.md` at the root — Claude reads it, shows you a draft wiki built from it, and asks only about what the interview left open. Then it creates:
   - `CONTEXT.md` — your domain's language
   - your wiki sections (`wiki/<section>/`)
   - a source template per type you use (emails, transcripts, …)

   `PROFILE.md` then moves into `sources/`, so everything you said in the interview gets distilled into the wiki like any other material. Without a `PROFILE.md`, Claude just runs the interview itself.
3. **Fill it up.** Onboarding ends by asking you to connect the systems you named and to point at the folders your work lives in. Claude surveys what's there without importing anything, writes you a plan in `meta/ingest-plan.md` to tick and edit, shows you a sample of each batch, and only then brings the batch in. You can skip this and come back to it later.
4. **Ingest material** as you go: ask Claude to pull it from your connected tools — *"check today's emails and add them"*, *"ingest the latest meeting"*. Claude fetches and files each as a source marked `#status/pending`. (Optionally, add a guidance note to any source to steer the next step.)
5. Ask Claude to **distill** whenever you want pending sources folded into the wiki.

There are no magic words. Ask for what you want in your own words — *"catch the wiki up"*, *"is anything out of date?"* — and Claude picks the right skill. The names below are just what those skills are called.

If you use the Obsidian Web Clipper, set its destination to `sources/clippings/`. Claude reaches your email / meetings / Drive / Slack through your connected tools — connect the ones you use.

## What belongs where

- `CONTEXT.md` — your domain's words and how they relate (Claude reads this to file things correctly).
- `CLAUDE.md` — the rules Claude follows.
- `PROFILE.md` — your kickoff interview, if you did one. Setup input only: Claude reads it once, then files it into `sources/`, and the root no longer holds it.
- `sources/` — raw material you add, kept once distilled. Flat; each note is tagged with its type (`#source/...`). `sources/clippings/` is the Web Clipper landing zone.
- `wiki/` — compiled knowledge in designed sections, plus `meetings/` and `maintenance/`.
- `meta/maintenance-log.md` — what Claude distilled, when, and who added the source.

## How it works

- **Sources are the archive; the wiki is the living synthesis on top of them.** Every distilled claim links back to its source; sources are never edited (their status flag just flips to `#status/distilled`). You can delete a source that hasn't been distilled yet — nothing cites it — which is your undo if an ingest pulled in junk. Once it's distilled, it stays.
- **You own structure, Claude owns content.** You (via `wiki-onboard`) decide the domain language and sections; Claude fills the pages.
- **Obsidian-native throughout** — tags for type/status, properties for who/when, wikilinks for every connection. Use the graph view and backlinks to navigate.
- **Claude reminds you when there is a backlog.** At the start of each session it checks for sources you have not distilled yet and unresolved items in `wiki/maintenance/open-questions.md`, and offers to work through them. Nothing happens until you say yes, and it stays quiet when there is nothing waiting.

## Skills

- `wiki-onboard` — set up or re-map the wiki (domain → sections → source templates).
- `wiki-ingest` — fetch material from your tools (email, meetings, Drive, Slack) into `sources/`.
- `wiki-distill` — distill pending sources into the wiki.
- `wiki-session-capture` — write what a Claude session settled straight into the wiki, skipping `sources/`.
- `wiki-lint` — health-check the wiki: fix broken links and indexes, flag contradictions and gaps.
- `grill-with-docs`, `obsidian-markdown` — helper skills used by the above.

Automation is kept to one thing: the session-start backlog check described above (`.claude/hooks/wiki-backlog-check.sh`, wired up in `.claude/settings.json`). Scheduling, search tooling, and the like are intentionally left out — add them later, only once the plain vault is useful.
