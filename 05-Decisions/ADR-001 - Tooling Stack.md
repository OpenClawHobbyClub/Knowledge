# ADR-001: Initial Tooling Stack

**Date:** 2026-04-08
**Status:** accepted
**Deciders:** Roger Reeuwijk, Wilson (PM Agent)

## Context

The product team is being stood up from scratch. We need foundational tools for knowledge management, task tracking, code management, and communication before the full board meeting on April 13.

## Decision

We adopt the following initial stack:

- **Think** → Obsidian (shared vault at `/opt/obsidian-vault/`)
- **Track** → Jira (SaaS)
- **Build** → Git (local) + GitHub (SaaS)
- **Talk** → Slack
- **External comms** → openclawhobbyclub@gmail.com

Additional tools (CI/CD, Figma, etc.) will be added when the pain justifies them — not before.

## Consequences

- All agents share the Obsidian vault, ensuring a single source of truth for docs
- Jira as SaaS means no infrastructure overhead but requires account setup
- Git is local-first with GitHub as remote — standard workflow
- Slack is already operational as the communication layer

## Alternatives Considered

- **Notion** instead of Obsidian — rejected because Obsidian is local-first/markdown-based, better for agent access and offline use
- **Linear** instead of Jira — considered but Jira was the explicit board preference
- **Self-hosted Git** (Gitea) — unnecessary complexity when GitHub SaaS is available
