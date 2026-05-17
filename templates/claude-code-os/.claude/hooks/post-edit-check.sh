#!/usr/bin/env bash
set -euo pipefail

echo "== Post-edit check suggestions =="

if [ -f package.json ]; then
  echo "- JavaScript/TypeScript project detected. Consider running lint, typecheck, and tests."
fi

if [ -f pyproject.toml ] || [ -f requirements.txt ]; then
  echo "- Python project detected. Consider running formatter, linter, type checker, and tests."
fi

if [ -f pubspec.yaml ]; then
  echo "- Flutter/Dart project detected. Consider running flutter analyze and flutter test."
fi

if [ -f Cargo.toml ]; then
  echo "- Rust project detected. Consider running cargo fmt, cargo clippy, and cargo test."
fi

echo "- If behavior changed, update docs and changelog."
