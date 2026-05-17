#!/usr/bin/env bash
set -euo pipefail

echo "== Claude Code session start =="

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo
  echo "Branch:"
  git branch --show-current || true

  echo
  echo "Uncommitted changes:"
  git status --short || true
fi

echo
echo "Context files:"
for file in PROJECT_CONTEXT.md SESSION_CONTEXT.md docs/OPEN_DECISIONS.md docs/IMPLEMENTATION_STATE.md; do
  if [ -f "$file" ]; then
    echo "- $file"
  else
    echo "- missing: $file"
  fi
done

echo
echo "Package manager hints:"
if [ -f package-lock.json ]; then echo "- npm"; fi
if [ -f pnpm-lock.yaml ]; then echo "- pnpm"; fi
if [ -f yarn.lock ]; then echo "- yarn"; fi
if [ -f uv.lock ]; then echo "- uv"; fi
if [ -f poetry.lock ]; then echo "- poetry"; fi
if [ -f pubspec.yaml ]; then echo "- flutter/dart"; fi
if [ -f Cargo.toml ]; then echo "- cargo"; fi
