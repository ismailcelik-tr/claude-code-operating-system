**Notice:** This guide should be reviewed periodically because Claude Code features such as Hooks, Plugins, Skills, MCP Servers, and Subagents may change over time.

## **Claude Code/CLI Working Architecture Guide**

It is important to clearly separate **CLAUDE.md, PROJECT_CONTEXT.md, SESSION_CONTEXT.md, Hooks, Custom Commands, and Rules**.

In Claude Code, `CLAUDE.md` works like project memory that Claude reads at the beginning of each session. According to the official documentation, project-level `./CLAUDE.md` can be used; the `/init` command can also analyze the existing codebase and generate an initial `CLAUDE.md` file. Claude Code also does not read `AGENTS.md` directly; it reads it when imported through `CLAUDE.md`.

It is more sensible to use Claude in this order:

```text
1. Manual prompt (/init)
2. CLAUDE.md
3. Custom command
4. Hook
5. Skill
6. Subagent
7. MCP Server
8. Plugin
```

## 1. First command to give Claude at the start of a project

```text
/init
```

Then provide a more professional prompt like the following (the next section should also be reviewed):

```text
Create or update the project-level CLAUDE.md file for this repository.

Before writing anything:
1. Inspect the repository structure.
2. Read README.md if it exists.
3. Read PROJECT_CONTEXT.md if it exists.
4. Read AGENTS.md if it exists.
5. Detect the tech stack, package manager, build commands, test commands, lint commands, and project architecture.
6. Do not modify application code.

Create a concise CLAUDE.md file that helps Claude Code work professionally in this project.

The file must include:
- Project overview
- Tech stack
- Repository structure
- Build, run, test, lint commands
- Coding conventions
- Architecture rules
- Git workflow rules
- Testing expectations
- Documentation update rules
- Security rules
- How to use PROJECT_CONTEXT.md and SESSION_CONTEXT.md
- How to update docs/OPEN_DECISIONS.md and docs/IMPLEMENTATION_STATE.md
- Rules for not overengineering
- Rules for asking before making destructive changes

If AGENTS.md exists, import it using @AGENTS.md and add Claude-specific instructions below it.

Keep CLAUDE.md under 200 lines if possible.
Do not include temporary task notes in CLAUDE.md.
Temporary state should go into SESSION_CONTEXT.md.
```

Before making Claude write code directly in each project, have it do this:

```text
(One sentence describing the project, followed by the section below)

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

Do not implement application features yet.

The goal is to make this repository easy to continue across multiple Claude Code sessions with minimal repeated explanation.
```

```text
CLAUDE.md = Claude's behavior rules
PROJECT_CONTEXT.md = the project's permanent architecture / product context
SESSION_CONTEXT.md = temporary continuation notes from the latest session
OPEN_DECISIONS.md = decisions that are not yet clarified
IMPLEMENTATION_STATE.md = which steps are done / what is next
CHANGELOG.md = changes that affect the user or the project
.claude/hooks = automatic security, quality, session start/stop checks
.claude/commands = repeated workflows
.claude/rules = technology-specific or folder-specific rules
.claude/agents = expert roles
.claude/skills = reusable expertise packages
MCP servers = external system connections
Plugins = the shareable package form of these structures
```

```text
When should each one be used?

Always-valid rule -> CLAUDE.md
Temporary session note -> SESSION_CONTEXT.md
Repeated manual task -> Custom command
Automatic check -> Hook
Expertise method -> Skill
Expert role -> Subagent
External system access -> MCP Server
Reusable package -> Plugin
Plugins = the shareable package form of these structures
```

---

```text
Where should I put something?

1. Is it a general Claude behavior rule?
   -> CLAUDE.md
2. Is it permanent project architecture / product information?
   -> PROJECT_CONTEXT.md
3. Is it temporary continuation information from the latest session?
   -> SESSION_CONTEXT.md
4. Is it a workflow I run repeatedly?
   -> .claude/commands/
5. Is it a security / quality check that must run automatically?
   -> .claude/hooks/
6. Is it a rule for a specific technology or folder?
   -> .claude/rules/
7. Is it a specific expertise method?
   -> .claude/skills/
8. Is it work that should be delegated to a specific expert role?
   -> .claude/agents/
9. Do I need data from an external system?
   -> MCP Server
10. Do I want to carry this structure into other projects too?
   -> Plugin
```

## (Alternative) Advanced command to give Claude at the start of a project

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

CLAUDE.md must remain concise and should not include long temporary notes.

Use this separation:

- CLAUDE.md = Claude Code behavior and project operating rules
- PROJECT_CONTEXT.md = permanent product and architecture context
- SESSION_CONTEXT.md = temporary continuation state
- docs/OPEN_DECISIONS.md = unresolved decisions
- docs/IMPLEMENTATION_STATE.md = implementation progress
- .claude/commands = reusable workflows
- .claude/hooks = automated checks and lifecycle scripts
- .claude/rules = technology or folder-specific rules
- .claude/agents = specialized subagent definitions
- .claude/skills = reusable expertise packages

Also recommend whether this project would benefit from MCP servers.

For each suggested MCP server, explain:

- purpose
- read-only or write access
- risks
- setup priority

Do not configure external services unless explicitly asked.
Do not create plugins yet unless the same setup is intended to be reused across multiple repositories.
```

## 2. Core structure for CLAUDE.md

`CLAUDE.md` should not become bloated. Official documentation also says short and clear instructions work better, and staying under 200 lines is healthier.

Recommended structure:

```md
# Claude Code Instructions

## Project Context

- Always read PROJECT_CONTEXT.md before making architectural or implementation decisions.
- Always read SESSION_CONTEXT.md when continuing a previous session.
- Use README.md for setup and user-facing project overview.
- Use docs/OPEN_DECISIONS.md for unresolved decisions.
- Use docs/IMPLEMENTATION_STATE.md for implementation progress.

## Working Style

- Think before editing.
- Prefer small, reviewable changes.
- Do not overengineer.
- Do not introduce new dependencies without explaining why.
- Do not rewrite large parts of the codebase unless explicitly asked.
- Before destructive actions, ask for confirmation.

## Development Workflow

Before implementation:

1. Understand the task.
2. Inspect relevant files.
3. Create a short plan.
4. Identify risks or open decisions.

During implementation:

1. Keep changes minimal.
2. Follow existing project conventions.
3. Add types and tests where appropriate.
4. Avoid unrelated refactors.

After implementation:

1. Run relevant checks.
2. Summarize changed files.
3. Update SESSION_CONTEXT.md.
4. Update docs/IMPLEMENTATION_STATE.md.
5. Update docs/OPEN_DECISIONS.md if decisions changed.

## Documentation Rules

- Permanent architecture decisions go into PROJECT_CONTEXT.md or ADR files.
- Temporary session notes go into SESSION_CONTEXT.md.
- Completed implementation progress goes into docs/IMPLEMENTATION_STATE.md.
- User-facing changes go into CHANGELOG.md.

## Safety Rules

- Never read or print secrets from .env files.
- Never commit secrets.
- Never run destructive database, filesystem, or deployment commands without confirmation.
- Do not use production credentials unless explicitly instructed.
```

## 3. Positioning hook logic correctly

`CLAUDE.md` tells Claude **how it should behave**.
A hook, on the other hand, **runs an automatic command** on specific events.

According to the official Claude Code documentation, the `SessionStart` hook runs when a new session starts or is resumed; it is useful for loading development context, showing recent changes, or preparing the environment.

```text
Start Hook / SessionStart Hook:
- Confirm current git branch
- Show uncommitted changes summary
- Read PROJECT_CONTEXT.md if present
- Read SESSION_CONTEXT.md if present
- Read docs/OPEN_DECISIONS.md if present
- Read docs/IMPLEMENTATION_STATE.md if present
- Detect package manager
- Check dependency install state
- Check whether lockfile exists
- Print recommended next steps as additional context
```

The `Stop` hook can also be used as an ending hook. Claude Code documentation gives examples where the `Stop` hook can check specific criteria before Claude stops.

```text
End Hook / Stop Hook:
- Check whether requested task is actually complete
- Check whether tests/lint were run or explain why not
- Update SESSION_CONTEXT.md
- Update docs/IMPLEMENTATION_STATE.md
- Update docs/OPEN_DECISIONS.md
- Update CHANGELOG.md if user-visible behavior changed
- Summarize modified files
- Warn about uncommitted changes
```

## 4. The most valuable things to add on the hook side

In Claude Code, the `PreToolUse` hook runs before Claude calls a tool and can control the call with allow/deny/ask/defer behavior. This is especially valuable for security.

For professional use:

### Security Hooks

```text
PreToolUse / Bash:
- block risky commands such as rm -rf, sudo rm, chmod -R 777
- ask for user approval for production deploy commands
- ask for approval for migration, db reset, docker volume prune commands
- block reading .env, secrets, and credentials files
```

### Code Quality Hooks

`PostToolUse` runs after Claude successfully uses a tool. The official documentation gives an example of running lint after `Write|Edit`.

```text
PostToolUse / Write|Edit:
- if the changed file is TypeScript, suggest npm run typecheck or npm run lint
- if Python, suggest ruff / mypy / pytest
- if Flutter, suggest flutter analyze
- if backend, run the relevant tests
```

### Documentation Hooks

```text
PostToolUse / Write|Edit:
- if critical files such as architecture/ or src/core changed, update docs/IMPLEMENTATION_STATE.md
- if public API changed, check README or API documentation
- if a decision changed, update docs/OPEN_DECISIONS.md or ADR
```

### Git Hook Logic

```text
SessionStart:
- current branch
- last commit
- uncommitted files
- changed files summary

Stop:
- modified files
- files not tested
- suggested commit message
- changelog candidate
```

### Dependency Guard

```text
PreToolUse / Bash:
- make it explain why commands such as npm install, pip install, brew install, flutter pub add are needed
- if package.json / pyproject.toml / pubspec.yaml changes, check the lockfile
```

## 5. Where should `.claude/settings.json` live?

In Claude Code, project settings are placed in `.claude/settings.json` and can be shared with the repository. Personal settings use `.claude/settings.local.json`; this file should not be committed.

Recommended structure: (Claude should be consulted at project start; content may change.)

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
|   |-- hooks/
|   |   |-- session-start.sh
|   |   |-- stop.sh
|   |   |-- guard-bash.sh
|   |   `-- post-edit-check.sh
|   |-- commands/
|   |   |-- continue-session.md
|   |   |-- implement-step.md
|   |   |-- review-changes.md
|   |   `-- close-session.md
|   `-- rules/
|       |-- security.md
|       |-- testing.md
|       |-- documentation.md
|       |-- frontend.md
|       |-- backend.md
|       `-- ai-rag.md (changes from project to project)
```

**Example `.claude/settings.json`**

```text
Create a .claude/settings.json file for this repository.

Configure professional Claude Code hooks:
- SessionStart should run .claude/hooks/session-start.sh
- Stop should run .claude/hooks/stop.sh
- PreToolUse for Bash should run .claude/hooks/guard-bash.sh
- PostToolUse for Write|Edit should run .claude/hooks/post-edit-check.sh

Also configure safe permissions:
- Deny reading .env files
- Deny reading secrets folders
- Deny destructive shell commands unless explicitly approved

Do not create overly broad permissions.
Keep the configuration suitable for a team-shared repository.
```

A target file can look roughly like this:

```json
{
  "$schema": "https://json.schemastore.org/claude-code-settings.json",
  "permissions": {
    "deny": [
      "Read(./.env)",
      "Read(./.env.*)",
      "Read(./secrets/**)",
      "Read(./config/credentials.json)"
    ]
  },
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/session-start.sh"
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/stop.sh"
          }
        ]
      }
    ],
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/guard-bash.sh"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          {
            "type": "command",
            "command": "${CLAUDE_PROJECT_DIR}/.claude/hooks/post-edit-check.sh"
          }
        ]
      }
    ]
  }
}
```

## 7. Adding custom commands also improves productivity

Hooks run automatically. But custom commands are better for workflows you use again and again.

For example:

```text
.claude/commands/continue-session.md
.claude/commands/implement-step.md
.claude/commands/review-changes.md
.claude/commands/close-session.md
.claude/commands/create-context.md
.claude/commands/update-docs.md
```

### `/continue-session`

```md
Read PROJECT_CONTEXT.md and SESSION_CONTEXT.md first.

Then:

1. Summarize the current project state.
2. List pending tasks.
3. Identify the next safest implementation step.
4. Do not modify code until you present a short plan.
```

### `/implement-step`

```md
Implement only the requested step: $ARGUMENTS

Requirements:

- Do not move beyond this step.
- Keep changes minimal and typed.
- Follow CLAUDE.md.
- Update docs/IMPLEMENTATION_STATE.md.
- Update SESSION_CONTEXT.md.
- Explain how to verify locally.
```

### `/close-session`

```md
Prepare the project for continuation in a future Claude Code session.

Update:

- SESSION_CONTEXT.md
- docs/IMPLEMENTATION_STATE.md
- docs/OPEN_DECISIONS.md
- CHANGELOG.md if relevant

Include:

- Completed work
- Pending work
- Modified files
- Commands run
- Tests/lint status
- Known issues
- Next recommended step

Do not modify application code unless required for documentation consistency.
```

## 8. Skills Logic: Reusable Expertise Packages

**Skills** can be thought of as reusable expertise packages given to Claude so it can perform a specific kind of work at a higher quality level.

A simple distinction can be made like this:

```text
CLAUDE.md = How should Claude behave in this project?
Command = How do I trigger this work repeatedly?
Skill = With which expertise / method should Claude do this work?
Subagent = Which expert role should handle this work?
MCP Server = Which external system should Claude be able to connect to?
Plugin = The packaged and shareable form of these structures
```

Skills are especially valuable in these cases:

```text
- Repeated work that is too complex to explain with a single command
- Work that requires specific quality standards
- Expertise that can be carried from project to project
- Areas such as code review, security analysis, RAG pipeline design, test strategy
```

Example skill ideas:

```text
skills/
|-- code-review/
|   `-- SKILL.md
|-- security-review/
|   `-- SKILL.md
|-- rag-architecture/
|   `-- SKILL.md
|-- react-native-mobile/
|   `-- SKILL.md
|-- flutter-mobile/
|   `-- SKILL.md
|-- backend-api-design/
|   `-- SKILL.md
`-- documentation-writer/
    `-- SKILL.md
```

Example `rag-architecture/SKILL.md`:

```md
# RAG Architecture Skill

Use this skill when designing, reviewing, or improving a Retrieval-Augmented Generation system.

## Goals

- Prefer simple, inspectable architecture.
- Separate ingestion, chunking, embedding, retrieval, reranking, prompting, and generation.
- Avoid overengineering in MVP stages.
- Make local development possible before adding cloud dependencies.
- Document every major architectural decision.

## Checklist

Before implementation:

1. Identify document types.
2. Define chunking strategy.
3. Define embedding model.
4. Define vector database.
5. Define retrieval strategy.
6. Define role-based prompting if needed.
7. Define evaluation strategy.

## Rules

- Do not hide too much logic inside opaque framework chains.
- Prefer explicit retrieval and prompt construction.
- Keep architecture explainable for portfolio projects.
- Update ADR files when a major decision is made.
```

```text
Commands are for workflows.
Skills are for expertise.

Wrong:
Making everything a command named "review-code".

Better:
Command: /review-changes
Skill: code-review
Subagent: code-reviewer
```

---

## 9. MCP Servers: Giving Claude Code Access to External Systems

**MCP Server** lets Claude Code connect to external tools, APIs, data sources, or services in a controlled way.

```text
Claude Code works on its own over the terminal + filesystem.
MCP Server gives Claude new capabilities.

Examples:
- Reading GitHub issues
- Pulling Linear tasks
- Searching Notion documents
- Querying a PostgreSQL database
- Accessing Figma designs
- Inspecting Sentry errors
- Listing AWS resources
```

MCP Servers are especially valuable for these tasks:

```text
- Connecting to project management tools
- Reading documentation sources
- Getting issue / ticket / task context
- Database or log analysis
- Secure integration with enterprise systems
```

Example usage scenario:

```text
In a backend project, you can have Claude read not only the code but also:
- GitHub issue content
- Linear task description
- Notion PRD document
- Sentry error record
so it can produce a more accurate solution.
```

| Need | Structure to use |
| --- | --- |
| Teach Claude rules from a file | `CLAUDE.md` |
| Start a repeated workflow | Custom command |
| Add expertise / methodology | Skill |
| Connect to external systems | MCP Server |
| Delegate a specific task to an expert agent | Subagent |
| Package and share all of it | Plugin |

---

Example MCP usage policy:

```md
## MCP Usage Rules

- Use MCP servers only when repository files are not enough.
- Prefer read-only access unless write access is explicitly needed.
- Do not expose secrets, credentials, tokens, or private customer data.
- For production systems, ask before making destructive or write operations.
- Summarize what external context was used before implementing changes.
```

Example prompt to give Claude:

```text
Review this repository and suggest which MCP servers would provide real value.

Consider:
- GitHub integration
- Linear or Jira integration
- Notion documentation
- Database inspection
- Error monitoring
- Cloud provider access

Do not configure anything yet.

For each recommended MCP server, explain:
- Why it is useful
- What risks it introduces
- Whether it should be read-only or writable
- Which workflows it improves
```

---

## 10. Plugins: Packaging Commands, Skills, Hooks, MCP, and Agent Structures

**Plugin** can be thought of as a reusable extension package in the Claude Code ecosystem. In the official Claude Code plugin explanation, plugins are described as extensions that bring together structures such as custom slash commands, specialized agents, hooks, and MCP servers.

In other words, a plugin does this:

```text
It turns the good Claude Code settings you use in one project
into something portable for other projects or teammates.
```

Example plugin logic:

```text
my-claude-code-plugin/
|-- commands/
|   |-- review-changes.md
|   |-- close-session.md
|   `-- implement-step.md
|-- agents/
|   |-- code-reviewer.md
|   |-- security-reviewer.md
|   `-- test-engineer.md
|-- skills/
|   |-- backend-api-design/
|   |   `-- SKILL.md
|   `-- rag-architecture/
|       `-- SKILL.md
|-- hooks/
|   |-- guard-bash.sh
|   `-- post-edit-check.sh
`-- README.md
```

You can explain plugins in your own guide like this:

```text
It is not necessary to write a plugin for every project at the beginning.

First, establish:
- CLAUDE.md
- PROJECT_CONTEXT.md
- SESSION_CONTEXT.md
- .claude/commands
- .claude/hooks
- .claude/rules

Then, once you start reusing the same structures in 3-4 projects,
it makes sense to turn them into a plugin.
```

## 11. Subagent Definitions: Splitting Work Across Expert Agents

**Subagent** can be thought of as a structure Claude uses to delegate a specific task to a more specialized role.

Subagents are especially useful in these cases:

```text
- Code review
- Writing tests
- Security analysis
- RAG pipeline evaluation
- Frontend UI review
- Backend API design review
- DevOps / deployment evaluation
- Documentation quality review
```

Example subagent structure:

```text
.claude/agents/
|-- code-reviewer.md
|-- security-reviewer.md
|-- test-engineer.md
|-- backend-architect.md
|-- mobile-architect.md
|-- rag-engineer.md
`-- documentation-maintainer.md
```

Example `code-reviewer.md`:

```md
# Code Reviewer Agent

## Role

You are a senior code reviewer.

## Responsibilities

- Review code for correctness, maintainability, readability, and security.
- Identify unnecessary complexity.
- Check whether the implementation follows CLAUDE.md.
- Check whether tests are needed.
- Avoid rewriting code unless explicitly asked.

## Review Checklist

1. Does the change solve the requested task?
2. Is the implementation minimal?
3. Are types and error handling sufficient?
4. Are there hidden side effects?
5. Are tests missing?
6. Is documentation affected?
7. Are there security or performance risks?

## Output Format

Return:

- Summary
- Issues found
- Suggested improvements
- Required fixes
- Optional improvements
```

Example `rag-engineer.md`:

```md
# RAG Engineer Agent

## Role

You are a RAG systems engineer focused on local, explainable, portfolio-quality AI systems.

## Responsibilities

- Review ingestion pipeline.
- Review chunking strategy.
- Review embedding model choice.
- Review vector database usage.
- Review retrieval quality.
- Review prompt construction.
- Review evaluation approach.

## Rules

- Prefer explicit, understandable RAG pipelines.
- Do not overuse frameworks.
- Keep MVP scope realistic.
- Make architecture decisions visible in ADR files.
- Consider local hardware limits.
```

Example `security-reviewer.md`:

```md
# Security Reviewer Agent

## Role

You are a security-focused reviewer.

## Responsibilities

- Detect secret leakage.
- Review authentication and authorization logic.
- Review unsafe shell commands.
- Review dependency risks.
- Review file upload and input validation paths.
- Review production deployment risks.

## Hard Rules

- Never print secrets.
- Never suggest bypassing security controls.
- Ask before destructive operations.
- Treat production credentials as highly sensitive.
```

Example prompt for using subagents:

```text
Use the appropriate subagents to review the current implementation.

Required reviews:
- code-reviewer
- security-reviewer
- test-engineer
- documentation-maintainer

Do not modify code yet.

Return:
1. Findings by subagent
2. Required fixes
3. Optional improvements
4. Suggested next implementation step
```

---

## 12. Adding Skills, MCP, Plugins, and Subagents to the Existing File Structure

You can expand the current recommended structure like this:

```text
project-root/
|-- CLAUDE.md
|-- PROJECT_CONTEXT.md
|-- SESSION_CONTEXT.md
|-- CHANGELOG.md
|-- docs/
|   |-- OPEN_DECISIONS.md
|   |-- IMPLEMENTATION_STATE.md
|   `-- ADR/
|-- .claude/
|   |-- settings.json
|   |-- settings.local.json
|   |-- hooks/
|   |   |-- session-start.sh
|   |   |-- stop.sh
|   |   |-- guard-bash.sh
|   |   `-- post-edit-check.sh
|   |-- commands/
|   |   |-- continue-session.md
|   |   |-- implement-step.md
|   |   |-- review-changes.md
|   |   |-- close-session.md
|   |   `-- create-context.md
|   |-- agents/
|   |   |-- code-reviewer.md
|   |   |-- security-reviewer.md
|   |   |-- test-engineer.md
|   |   |-- backend-architect.md
|   |   |-- mobile-architect.md
|   |   `-- rag-engineer.md
|   |-- skills/
|   |   |-- code-review/
|   |   |   `-- SKILL.md
|   |   |-- security-review/
|   |   |   `-- SKILL.md
|   |   |-- rag-architecture/
|   |   |   `-- SKILL.md
|   |   `-- documentation/
|   |       `-- SKILL.md
|   `-- rules/
|       |-- security.md
|       |-- testing.md
|       |-- documentation.md
|       |-- frontend.md
|       |-- backend.md
|       `-- ai-rag.md
```

---

## 13. How Should These Structures Be Written Into CLAUDE.md?

To avoid bloating `CLAUDE.md`, all agent, skill, and MCP details should not be embedded inside it. Instead, `CLAUDE.md` should only act as a router.

A section that can be added:

```md
## Claude Code Extensions

This project may use Claude Code extensions such as commands, hooks, rules, skills, subagents, MCP servers, and plugins.

### Commands

Reusable workflows are stored in:

- .claude/commands/

Use commands for repeated workflows such as:

- continuing a session
- implementing a specific step
- reviewing changes
- closing a session

### Hooks

Automation and safety checks are stored in:

- .claude/hooks/

Hooks may be used for:

- session start context loading
- stop-time session summary
- dangerous bash command prevention
- post-edit lint/test suggestions

### Rules

Project-specific rules are stored in:

- .claude/rules/

Use these rules when working in relevant parts of the codebase.

### Skills

Reusable expertise packs are stored in:

- .claude/skills/

Use skills when a task requires a specific methodology, such as:

- code review
- security review
- RAG architecture
- documentation writing
- mobile architecture

### Subagents

Specialized agents are stored in:

- .claude/agents/

Use subagents for focused review or implementation support.

Examples:

- code-reviewer
- security-reviewer
- test-engineer
- backend-architect
- mobile-architect
- rag-engineer
- documentation-maintainer

### MCP Servers

Use MCP servers only when repository context is not enough.

MCP servers may provide access to:

- GitHub
- Linear / Jira
- Notion
- Figma
- databases
- monitoring tools
- cloud providers

Rules:

- Prefer read-only access by default.
- Ask before write operations.
- Never expose secrets.
- Summarize external context used.
```

---
