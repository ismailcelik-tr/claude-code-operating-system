#!/usr/bin/env bash
set -euo pipefail

echo "== Claude Code session stop =="

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo
  echo "Modified files:"
  git status --short || true
fi

echo
echo "Before closing, confirm:"
echo "- SESSION_CONTEXT.md reflects the latest state."
echo "- docs/IMPLEMENTATION_STATE.md reflects completed and pending work."
echo "- docs/OPEN_DECISIONS.md reflects unresolved decisions."
echo "- Relevant tests, lint, typecheck, or build commands were run or explicitly skipped."
