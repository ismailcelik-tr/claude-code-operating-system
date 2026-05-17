# Security Policy

This repository contains documentation, templates, and example automation patterns for Claude Code projects.

## Reporting a security issue

If you find a security concern in the templates or examples, please open a private security advisory if available, or contact the repository owner directly.

Do not publicly disclose:

- Real credentials
- Tokens
- Private customer data
- Production system details
- Exploitable examples against a live system

## Security principles used here

- Keep secrets out of prompts, logs, commits, and generated documentation.
- Prefer read-only external integrations unless write access is required.
- Ask for confirmation before destructive filesystem, database, deployment, or cloud commands.
- Treat production credentials as sensitive even when a local agent can technically access them.
- Use hooks as guardrails, not as a substitute for human review.

## Template safety note

The included hooks are examples. Review and adapt them before using them in a production repository.
