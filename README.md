<p align="center">
  <img src="https://cdn.simpleicons.org/claude/000000" width="120" height="120" alt="Claude logo">
</p>

<h1 align="center">Claude Code Operating System</h1>

<p align="center">
  <a href="./LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/License-MIT-2ea44f?style=flat-square"></a>
  <a href="./README.tr.md"><img alt="Language: English and Turkish" src="https://img.shields.io/badge/Language-EN%20%2F%20TR-1f6feb?style=flat-square"></a>
  <img alt="Claude Code" src="https://img.shields.io/badge/Built%20for-Claude%20Code-000000?style=flat-square">
  <img alt="Templates included" src="https://img.shields.io/badge/Templates-Included-6f42c1?style=flat-square">
  <img alt="AI agent ready" src="https://img.shields.io/badge/AI%20Agents-Ready-ff7b72?style=flat-square">
</p>

<p align="center">
  A practical repository structure for long-running Claude Code projects.
  <br>
  <a href="./README.tr.md">Turkish README</a> | <a href="./CLAUDE-CODE-OPERATING-GUIDE.md">Full guide</a> | <a href="./templates/claude-code-os">Templates</a> | <a href="./docs/OPERATING-MODEL.md">Operating model</a>
</p>

> [!NOTE]
> Claude Code features such as hooks, skills, plugins, MCP servers, and subagents may evolve over time. Treat this repository as an operating model that should be reviewed periodically.

## Why this repository exists

Modern AI-assisted development is shifting from:
- prompt-based coding
to:
- persistent AI operating systems

This repository explores how to structure long-running software projects for AI coding agents such as Claude Code.

The goal is simple: stop re-explaining the same project context in every session, and instead give the AI agent a durable operating layer made of instructions, context, commands, hooks, rules, skills, agents, and integrations.

## The core idea

Claude Code becomes more useful when the repository itself explains how work should continue.

Use this separation:

| File or folder | Purpose |
| --- | --- |
| `CLAUDE.md` | Durable Claude Code behavior rules for the project |
| `PROJECT_CONTEXT.md` | Permanent product, architecture, and domain context |
| `SESSION_CONTEXT.md` | Temporary continuation notes from the latest work session |
| `docs/OPEN_DECISIONS.md` | Unresolved decisions that should not be guessed silently |
| `docs/IMPLEMENTATION_STATE.md` | What is done, what is in progress, and what comes next |
| `.claude/commands/` | Reusable slash-command workflows |
| `.claude/hooks/` | Automated lifecycle, safety, and quality checks |
| `.claude/rules/` | Technology-specific or folder-specific rules |
| `.claude/agents/` | Specialized subagent role definitions |
| `.claude/skills/` | Reusable expertise packages |
| MCP servers | Controlled access to external systems |
| Plugins | Portable bundles of commands, hooks, skills, agents, and MCP configuration |

## Recommended adoption order

Start small. Add more structure only when it solves a real continuity or quality problem.

```text
1. Manual prompt or /init
2. CLAUDE.md
3. PROJECT_CONTEXT.md and SESSION_CONTEXT.md
4. Custom commands
5. Hooks
6. Rules
7. Skills
8. Subagents
9. MCP servers
10. Plugins
```

## Quick start

Copy the starter template into a new or existing project:

```bash
cp -R templates/claude-code-os/. /path/to/your-project/
```

Then ask Claude Code to adapt it:

```text
Create or update the Claude Code operating structure for this repository.

Before writing anything:
1. Inspect the repository structure.
2. Read README.md if it exists.
3. Read PROJECT_CONTEXT.md if it exists.
4. Read AGENTS.md if it exists.
5. Detect the tech stack, package manager, build commands, test commands, lint commands, and architecture.
6. Do not modify application code.

Update the Claude Code operating files so this project can continue across multiple sessions with minimal repeated explanation.
Keep CLAUDE.md concise and put temporary state in SESSION_CONTEXT.md.
```

## Repository contents

```text
.
|-- CLAUDE-CODE-OPERATING-GUIDE.md
|-- CLAUDE-CODE-OPERATING-GUIDE.tr.md
|-- CHANGELOG.md
|-- CONTRIBUTING.md
|-- LICENSE
|-- README.md
|-- README.tr.md
|-- SECURITY.md
|-- docs/
|   |-- OPERATING-MODEL.md
|   `-- OPERATING-MODEL.tr.md
|-- examples/
|   `-- starter-layout/
`-- templates/
    `-- claude-code-os/
        |-- CLAUDE.md
        |-- PROJECT_CONTEXT.md
        |-- SESSION_CONTEXT.md
        |-- CHANGELOG.md
        |-- docs/
        `-- .claude/
```

## What belongs where?

| Need | Put it in |
| --- | --- |
| A rule Claude should always follow | `CLAUDE.md` |
| Permanent architecture or product context | `PROJECT_CONTEXT.md` |
| Notes from the last unfinished session | `SESSION_CONTEXT.md` |
| A repeated manual workflow | `.claude/commands/` |
| An automatic safety or quality check | `.claude/hooks/` |
| A rule for a specific technology or folder | `.claude/rules/` |
| A reusable method or area of expertise | `.claude/skills/` |
| A specialized role for delegated work | `.claude/agents/` |
| External project data | MCP server |
| A reusable bundle for multiple projects | Plugin |

## Template highlights

- A compact `CLAUDE.md` that avoids becoming a dumping ground.
- Persistent and temporary context files separated from each other.
- Session start and stop hook examples.
- Bash guard examples for risky commands and secret files.
- Reusable command prompts such as `continue-session`, `implement-step`, `review-changes`, and `close-session`.
- Agent role examples for code review, security review, and documentation maintenance.
- Rules for testing, security, and documentation updates.

## Design principles

- Keep instructions short enough to be read every session.
- Store stable project knowledge separately from temporary session state.
- Prefer small, reviewable changes over broad rewrites.
- Make open decisions explicit instead of letting the agent guess.
- Use hooks for automatic checks, commands for repeated workflows, skills for reusable expertise, and agents for specialized review.
- Add MCP servers only when repository files are not enough.
- Turn the setup into a plugin only after it has proven useful across multiple projects.

## Related documents

- [Operating model](./docs/OPERATING-MODEL.md)
- [Full Claude Code operating guide](./CLAUDE-CODE-OPERATING-GUIDE.md)
- [Turkish full guide](./CLAUDE-CODE-OPERATING-GUIDE.tr.md)
- [Turkish operating model](./docs/OPERATING-MODEL.tr.md)
- [Starter layout example](./examples/starter-layout/README.md)
- [Template package](./templates/claude-code-os)

## Disclaimer

This project is an independent community guide. It is not affiliated with Anthropic or Claude. Claude and Claude Code are trademarks of their respective owners.

## License

MIT. See [LICENSE](./LICENSE).
