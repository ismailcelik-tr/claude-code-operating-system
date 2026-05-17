# Starter Layout Example

This example shows how the template is meant to sit inside an application repository.

```text
project-root/
|-- CLAUDE.md
|-- PROJECT_CONTEXT.md
|-- SESSION_CONTEXT.md
|-- CHANGELOG.md
|-- docs/
|   |-- OPEN_DECISIONS.md
|   `-- IMPLEMENTATION_STATE.md
|-- .claude/
|   |-- settings.json
|   |-- commands/
|   |   |-- continue-session.md
|   |   |-- implement-step.md
|   |   |-- review-changes.md
|   |   `-- close-session.md
|   |-- hooks/
|   |   |-- session-start.sh
|   |   |-- stop.sh
|   |   |-- guard-bash.sh
|   |   `-- post-edit-check.sh
|   |-- rules/
|   |   |-- security.md
|   |   |-- testing.md
|   |   `-- documentation.md
|   |-- agents/
|   |   |-- code-reviewer.md
|   |   |-- security-reviewer.md
|   |   `-- documentation-maintainer.md
|   `-- skills/
|       `-- documentation-writer/
|           `-- SKILL.md
`-- src/
```

## Suggested first prompt

```text
Create or update the Claude Code operating structure for this repository.

Before writing anything:
1. Inspect the repository structure.
2. Read README.md if it exists.
3. Read PROJECT_CONTEXT.md if it exists.
4. Read AGENTS.md if it exists.
5. Detect the tech stack, package manager, build commands, test commands, lint commands, and architecture.
6. Do not modify application code.

Create or update:
- CLAUDE.md
- PROJECT_CONTEXT.md
- SESSION_CONTEXT.md
- docs/OPEN_DECISIONS.md
- docs/IMPLEMENTATION_STATE.md
- .claude/settings.json
- .claude/commands/
- .claude/hooks/
- .claude/rules/
- .claude/agents/
- .claude/skills/

Keep CLAUDE.md concise.
Put temporary task state in SESSION_CONTEXT.md.
Do not configure external services unless explicitly asked.
```
