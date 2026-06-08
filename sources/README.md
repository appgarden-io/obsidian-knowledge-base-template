# Sources

Raw material you add, kept forever as the source of truth. Claude reads from here but never edits or deletes a source — after distilling, it only flips the note's `#status/pending` tag to `#status/distilled`.

## How it works

- The folder is **flat**. A source's *type* is a tag (`#source/email`, `#source/transcript`, …), not a folder.
- `sources/clippings/` is the landing zone for the **Obsidian Web Clipper**.
- Every source carries a header: who added it, when, its own date, its type tag, and `#status/pending` — plus a few type-specific fields. You don't write these by hand: Claude does it when you say *"I added X"*, and the Web Clipper template does it for clips.

`wiki-onboard` creates a `_template-<type>.md` for each source type your team uses.
