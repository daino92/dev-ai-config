# dev-ai-config

Central source of truth for reusable AI-development instructions across macOS, Windows, Cursor, Codex, and Claude Code.

## Repository layout

- `shared/skills/`: canonical reusable skills.
- `shared/instructions/`: cross-tool engineering guidance.
- `cursor/rules/`: Cursor-specific project rules.
- `codex/`: Codex integration notes.
- `claude/`: Claude Code integration notes.
- `scripts/`: repeatable machine setup helpers.

## Setup

### Windows / Cursor + Codex

Clone the repository and switch to `develop`:

```powershell
git clone https://github.com/daino92/dev-ai-config.git
cd dev-ai-config
git checkout develop
git pull
```

If PowerShell blocks local scripts with an execution-policy error, allow scripts only for the current terminal session:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

This does not permanently change the machine's execution policy. The setting is discarded when the PowerShell session is closed.

Run the installer:

```powershell
.\scripts\install-windows.ps1
```

The installer links the shared skills into:

```text
%USERPROFILE%\.agents\skills
%USERPROFILE%\.cursor\skills
%USERPROFILE%\.codex\skills
```

The source of truth remains:

```text
dev-ai-config\shared\skills
```

The installer does not modify Cursor-managed `%USERPROFILE%\.cursor\skills-cursor`.

#### Verify the installation

Check the installed shared skills:

```powershell
Get-ChildItem $HOME\.agents\skills
```

Check the installed Cursor skills:

```powershell
Get-ChildItem $HOME\.cursor\skills
```

Check the installed Codex skills:

```powershell
Get-ChildItem $HOME\.codex\skills
```

Verify that a Cursor skill is a junction to this repository:

```powershell
Get-Item $HOME\.cursor\skills\react | Format-List Name,LinkType,Target
```

Verify the same for Codex:

```powershell
Get-Item $HOME\.codex\skills\react | Format-List Name,LinkType,Target
```

The expected result should include:

```text
LinkType : Junction
Target   : ...\dev-ai-config\shared\skills\react
```

After setup, restart Cursor and VS Code so their AI integrations can reload the available skills.

Because the installed skills are junctions, future updates normally only require:

```powershell
git checkout develop
git pull
```

Changes under `shared/skills/` are then immediately visible through the existing junctions.

### macOS

```bash
git clone https://github.com/daino92/dev-ai-config.git
cd dev-ai-config
git checkout develop
git pull
chmod +x scripts/install-macos.sh
./scripts/install-macos.sh
```

The macOS installer links the shared skills into `~/.agents/skills` and the available Codex, Cursor, and Claude skill directories. Existing skill directories with the same name are left in place; the installer reports them as skipped.

## Importing existing local skills from macOS

If you add skills locally under `~/.agents/skills` or `~/.codex/skills`, run:

```bash
git checkout develop
git pull
git checkout -b feature/import-my-local-skills
chmod +x scripts/import-codex-skills.sh
./scripts/import-codex-skills.sh
```

The importer copies only skill directories that do not already exist in `shared/skills/`. It skips generated Python caches. Review the imported files before committing, especially for secrets, private company information, or machine-specific paths. Built-in Codex skills under `~/.codex/skills/.system` are not imported.

The 55 locally installed skills from `~/.agents/skills` are included in `shared/skills/` with their supporting files. After cloning this repository on another PC, run the installer for that OS and restart the AI tools to load them. Some skills call platform-specific tools, so their instructions may still require software available only on a particular OS.

## Adding a skill

1. Create `feature/<skill-name>` from `develop`.
2. Add `shared/skills/<skill-name>/SKILL.md`.
3. Keep the skill tool-agnostic where possible.
4. Add tool-specific adapters only when necessary.
5. Open a PR to `develop`.

## Security

Never commit API keys, tokens, cookies, `.env` files, credentials, confidential company material, personal data, or machine-specific absolute paths.
