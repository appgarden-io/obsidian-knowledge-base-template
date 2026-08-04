#!/usr/bin/env bash
# Session-start backlog check for the company wiki.
#
# Counts what is waiting: source notes still tagged #status/pending, and
# unresolved items in wiki/maintenance/open-questions.md. If anything is
# waiting it prints a note for the agent, which relays it to the user and
# offers to run wiki-distill. Silent when the vault is clean.
#
# Wired in as a SessionStart hook by .claude/settings.json. Lives here rather
# than under .claude/ so any agent tool can reuse it.

set -uo pipefail

root="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"

# Source notes awaiting distill. Match the frontmatter tag line itself, not any
# prose mention of #status/pending (sources/README.md has one). `_template-*.md`
# files carry the tag as part of their schema and are not real sources.
pending=0
if [ -d "$root/sources" ]; then
  pending=$(find "$root/sources" -type f -name '*.md' ! -name '_template-*' \
    -exec grep -lE '^[[:space:]]*-[[:space:]]*status/pending[[:space:]]*$' {} + 2>/dev/null \
    | wc -l | tr -d ' ')
fi

# Unresolved items in open-questions.md — every bullet except the placeholders
# the file ships with.
questions=0
open_questions="$root/wiki/maintenance/open-questions.md"
if [ -f "$open_questions" ]; then
  questions=$(grep -E '^[[:space:]]*-[[:space:]]+' "$open_questions" 2>/dev/null \
    | grep -vic -E 'none yet|no open questions yet' | tr -d ' ')
fi

[ "$pending" -eq 0 ] && [ "$questions" -eq 0 ] && exit 0

parts=""
[ "$pending" -gt 0 ] && parts="$pending source note(s) still tagged #status/pending"
if [ "$questions" -gt 0 ]; then
  [ -n "$parts" ] && parts="$parts and "
  parts="$parts$questions unresolved item(s) in wiki/maintenance/open-questions.md"
fi

echo "[wiki backlog] The vault has $parts."
echo "Mention this to the user early in your first reply and offer to run wiki-distill" \
     "(and to work through the open questions). Do not start distilling unless they ask."
