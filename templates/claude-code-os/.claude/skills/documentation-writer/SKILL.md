# Documentation Writer Skill

Use this skill when creating or improving project documentation for an AI-assisted codebase.

## Goals

- Make the repository easy to continue across future AI coding sessions.
- Separate permanent context from temporary session state.
- Keep instructions concise, concrete, and easy to verify.
- Prefer examples that can be copied into real projects.

## Checklist

Before writing:

1. Read `README.md` if it exists.
2. Read `CLAUDE.md` if it exists.
3. Read `PROJECT_CONTEXT.md` if it exists.
4. Read `SESSION_CONTEXT.md` if it exists.
5. Inspect `docs/OPEN_DECISIONS.md` and `docs/IMPLEMENTATION_STATE.md` if present.

When writing:

1. Put durable rules in `CLAUDE.md`.
2. Put stable project context in `PROJECT_CONTEXT.md`.
3. Put temporary continuation notes in `SESSION_CONTEXT.md`.
4. Put unresolved decisions in `docs/OPEN_DECISIONS.md`.
5. Put progress state in `docs/IMPLEMENTATION_STATE.md`.

## Rules

- Do not bury temporary notes in long-term instruction files.
- Do not invent project facts when files do not provide them.
- Ask for clarification when a missing decision would affect implementation.
- Keep docs useful for both humans and coding agents.
