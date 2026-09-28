# dev-ai-config

Central source of truth for reusable AI-development instructions across macOS, Windows, Cursor, Codex, and Claude Code.

## Branching model

This repository follows GitFlow:

- `main`: stable/release-ready configuration.
- `develop`: integration branch and normal PR target.
- `feature/*`: new skills, rules, or tooling; branch from `develop`.
- `release/*`: optional release hardening; branch from `develop`, merge to `main` and back to `develop`.
- `hotfix/*`: urgent fixes; branch from `main`, merge to `main` and `develop`.

Do not push directly to `main` or `develop`.

## Repository layout

- `shared/skills/`: canonical reusable skills.
- `shared/instructions/`: cross-tool engineering guidance.
- `cursor/rules/`: Cursor-specific project rules.
- `codex/`: Codex integration notes.
- `claude/`: Claude Code integration notes.
- `scripts/`: repeatable machine setup helpers.

## Setup

### Windows / Cursor

```powershell
git clone https://github.com/daino92/dev-ai-config.git
cd dev-ai-config
.\scripts\install-windows.ps1
```

### macOS

```bash
git clone https://github.com/daino92/dev-ai-config.git
cd dev-ai-config
chmod +x scripts/install-macos.sh
./scripts/install-macos.sh
```

## Adding a skill

1. Create `feature/<skill-name>` from `develop`.
2. Add `shared/skills/<skill-name>/SKILL.md`.
3. Keep the skill tool-agnostic where possible.
4. Add tool-specific adapters only when necessary.
5. Open a PR to `develop`.

## Security

Never commit API keys, tokens, cookies, `.env` files, credentials, confidential company material, personal data, or machine-specific absolute paths.
