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
2. Ask Claude to **set up your wiki** (it runs the `wiki-onboard` skill). It interviews you about your domain, then creates:
   - `CONTEXT.md` — your domain's language
   - your wiki sections (`wiki/<section>/`)
   - a source template per type you use (emails, transcripts, …)
3. **Ingest material**: ask Claude to pull it from your connected tools — *"check today's emails and add them"*, *"ingest the latest meeting"*. Claude fetches and files each as a source marked `#status/pending`. (Optionally, add a guidance note to any source to steer the next step.)
4. Say **"distill"** whenever you want Claude to fold pending sources into the wiki.

If you use the Obsidian Web Clipper, set its destination to `sources/clippings/`. Claude reaches your email / meetings / Drive / Slack through your connected tools — connect the ones you use.

## What belongs where

- `CONTEXT.md` — your domain's words and how they relate (Claude reads this to file things correctly).
- `CLAUDE.md` — the rules Claude follows.
- `sources/` — raw material you add, kept forever. Flat; each note is tagged with its type (`#source/...`). `sources/clippings/` is the Web Clipper landing zone.
- `wiki/` — compiled knowledge in designed sections, plus `meetings/` and `maintenance/`.
- `meta/maintenance-log.md` — what Claude distilled, when, and who added the source.

## How it works

- **Sources are the archive; the wiki is the living synthesis on top of them.** Every distilled claim links back to its source; sources are never edited or deleted (their status flag just flips to `#status/distilled`).
- **You own structure, Claude owns content.** You (via `wiki-onboard`) decide the domain language and sections; Claude fills the pages.
- **Obsidian-native throughout** — tags for type/status, properties for who/when, wikilinks for every connection. Use the graph view and backlinks to navigate.

## Skills

- `wiki-onboard` — set up or re-map the wiki (domain → sections → source templates).
- `wiki-ingest` — fetch material from your tools (email, meetings, Drive, Slack) into `sources/`.
- `wiki-distill` — distill pending sources into the wiki.
- `wiki-lint` — health-check the wiki: fix broken links and indexes, flag contradictions and gaps.
- `grill-with-docs`, `obsidian-markdown` — helper skills used by the above.

Automation — scheduling, search tooling, and the like — is intentionally left out. Add it later, only once the plain vault is useful.
