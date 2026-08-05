#!/usr/bin/env bash
# Session-start resume check for an unfinished onboarding.
#
# wiki-onboard maintains meta/onboarding-progress.md as it works. If that file
# exists and the run is still in progress, this prints the stages left and the
# recorded next step, so a new session opens knowing where the last one stopped.
# Silent when no onboarding is in flight (file absent, or status: complete).
#
# Wired in as a SessionStart hook by .claude/settings.json.

set -uo pipefail

root="${CLAUDE_PROJECT_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"
progress="$root/meta/onboarding-progress.md"

[ -f "$progress" ] || exit 0

# Only speak while the run is unfinished.
grep -qE '^status:[[:space:]]*in-progress[[:space:]]*$' "$progress" 2>/dev/null || exit 0

done_count=$(grep -cE '^[[:space:]]*-[[:space:]]\[[xX]\][[:space:]]' "$progress" 2>/dev/null | tr -d ' ')
todo=$(grep -E '^[[:space:]]*-[[:space:]]\[[[:space:]]\][[:space:]]' "$progress" 2>/dev/null \
  | sed 's/^[[:space:]]*-[[:space:]]\[[[:space:]]\][[:space:]]*/  · /')

# First non-heading, non-blank line under "## Next step".
next=$(sed -n '/^##[[:space:]]*Next step/,$p' "$progress" 2>/dev/null \
  | grep -vE '^##' | grep -E '\S' | head -1)

echo "[wiki onboarding] An onboarding run is unfinished — $done_count stage(s) done. Still to do:"
[ -n "$todo" ] && echo "$todo"
[ -n "$next" ] && echo "Recorded next step: $next"
echo "Raise this with the user early in your first reply and offer to resume wiki-onboard" \
     "from meta/onboarding-progress.md. Do not resume unless they ask."
