# Claude Code Operating Model

This document expands the short README into a practical operating model for repositories that will be maintained with Claude Code over many sessions.

## 1. The problem

AI coding sessions often fail for simple reasons:

- The agent does not know the current project state.
- Temporary decisions are mixed with permanent architecture.
- The same setup, testing, and safety rules are repeated manually.
- Long-running work loses continuity between sessions.
- External context such as issues, docs, or monitoring is connected too late or too broadly.

The operating model in this repository gives each kind of context a home.

## 2. The baseline files

### `CLAUDE.md`

Use `CLAUDE.md` for durable behavior rules.

Good content:

- Project working style
- Build, test, and lint expectations
- Architecture boundaries
- Git workflow rules
- Safety rules
- Documentation update rules

Avoid:

- Temporary task notes
- Long issue dumps
- Raw meeting notes
- Unstable implementation status

Keep it short enough to be read frequently.

### `PROJECT_CONTEXT.md`

Use `PROJECT_CONTEXT.md` for permanent project knowledge.

Good content:

- Product purpose
- Target users
- Domain language
- Architecture overview
- Important constraints
- Non-goals
- Integration map

This file should change slowly.

### `SESSION_CONTEXT.md`

Use `SESSION_CONTEXT.md` for continuation state.

Good content:

- Last completed work
- Current branch
- Files touched recently
- Commands run
- Tests and lint status
- Known issues
- Next recommended step

This file should change often and should be refreshed at session close.

## 3. Commands, hooks, rules, skills, and agents

| Layer | Use it for | Example |
| --- | --- | --- |
| Custom command | A repeated manual workflow | `/continue-session` |
| Hook | An automatic lifecycle or safety check | Block risky Bash commands |
| Rule | A technology or folder-specific constraint | Frontend accessibility rules |
| Skill | A reusable method or expertise package | RAG architecture review |
| Subagent | A specialized review or implementation role | Security reviewer |

## 4. Hooks

Hooks should automate checks that are easy to forget.

Suggested `SessionStart` checks:

- Confirm current branch.
- Show uncommitted changes.
- Read project and session context files.
- Show open decisions.
- Detect package manager and available commands.

Suggested `Stop` checks:

- Confirm whether the requested task is complete.
- Record tests or lint commands that were run.
- Update session context.
- Update implementation state.
- Warn about uncommitted changes.

Suggested `PreToolUse` checks:

- Block or require confirmation for destructive commands.
- Prevent accidental reads of `.env` or credential files.
- Ask before production deploy, database reset, or migration commands.

Suggested `PostToolUse` checks:

- Recommend lint or typecheck after source edits.
- Recommend docs updates after public behavior changes.
- Recommend implementation state updates after feature work.

## 5. MCP servers

Use MCP servers when repository files are not enough.

Good candidates:

- GitHub issues and pull requests
- Linear or Jira tickets
- Notion product docs
- Sentry errors
- Database inspection
- Figma design files

Default posture:

- Prefer read-only access.
- Add write access only when the workflow truly needs it.
- Do not expose secrets or private customer data.
- Summarize what external context was used before making changes.

## 6. Plugins

Do not start by writing a plugin.

Start with repository-level files:

- `CLAUDE.md`
- `PROJECT_CONTEXT.md`
- `SESSION_CONTEXT.md`
- `.claude/commands`
- `.claude/hooks`
- `.claude/rules`
- `.claude/agents`
- `.claude/skills`

When the same structure proves useful across several repositories, package it as a plugin.

## 7. Practical rollout

Use this sequence for a new project:

1. Ask Claude Code to inspect the repository without editing application code.
2. Create the baseline context files.
3. Add only the commands you will actually use.
4. Add safety hooks before productivity hooks.
5. Add rules where the project has real conventions.
6. Add agents for review workflows.
7. Add skills for reusable expertise.
8. Add MCP servers for external context.
9. Convert repeated setups into a plugin.

## 8. Maintenance loop

At the end of meaningful sessions:

1. Update `SESSION_CONTEXT.md`.
2. Update `docs/IMPLEMENTATION_STATE.md`.
3. Update `docs/OPEN_DECISIONS.md` when decisions changed.
4. Update user-facing docs when behavior changed.
5. Record which checks were run.
6. Commit small, reviewable changes.
