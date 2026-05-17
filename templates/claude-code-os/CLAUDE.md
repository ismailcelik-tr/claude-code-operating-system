# Claude Code Instructions

## Project Context

- Read `PROJECT_CONTEXT.md` before making architecture or implementation decisions.
- Read `SESSION_CONTEXT.md` when continuing a previous session.
- Use `README.md` for setup and user-facing project overview.
- Use `docs/OPEN_DECISIONS.md` for unresolved decisions.
- Use `docs/IMPLEMENTATION_STATE.md` for implementation progress.

## Working Style

- Think before editing.
- Prefer small, reviewable changes.
- Follow existing project conventions.
- Do not overengineer.
- Do not introduce new dependencies without explaining why.
- Do not rewrite large areas of the codebase unless explicitly asked.
- Ask before destructive filesystem, database, deployment, or git history operations.

## Development Workflow

Before implementation:

1. Understand the task.
2. Inspect relevant files.
3. Identify risks or open decisions.
4. Make a short plan for non-trivial changes.

During implementation:

1. Keep changes focused.
2. Add types and tests where appropriate.
3. Avoid unrelated refactors.
4. Update documentation when behavior or architecture changes.

After implementation:

1. Run relevant checks when feasible.
2. Summarize changed files.
3. Update `SESSION_CONTEXT.md`.
4. Update `docs/IMPLEMENTATION_STATE.md`.
5. Update `docs/OPEN_DECISIONS.md` if decisions changed.

## Documentation Rules

- Permanent architecture decisions go into `PROJECT_CONTEXT.md` or ADR files.
- Temporary session notes go into `SESSION_CONTEXT.md`.
- Completed implementation progress goes into `docs/IMPLEMENTATION_STATE.md`.
- User-facing changes go into `CHANGELOG.md`.

## Safety Rules

- Never read, print, or commit secrets from `.env` files.
- Never commit credentials, private keys, tokens, or customer data.
- Do not use production credentials unless explicitly instructed.
- Ask before running destructive commands.
