#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$REPO_ROOT/shared/skills"

CODEX_DIR="$HOME/.codex/skills"
CURSOR_DIR="$HOME/.cursor/skills"
CLAUDE_DIR="$HOME/.claude/skills"
AGENTS_DIR="$HOME/.agents/skills"

if [ ! -d "$SOURCE" ]; then
  echo "Shared skills directory not found:"
  echo "  $SOURCE"
  exit 1
fi

link_skills() {
  local tool_name="$1"
  local target="$2"

  echo
  echo "Installing skills for $tool_name..."
  echo "Target: $target"
  echo

  mkdir -p "$target"

  for skill in "$SOURCE"/*; do
    [ -d "$skill" ] || continue

    name="$(basename "$skill")"
    destination="$target/$name"

    if [ -L "$destination" ]; then
      current_target="$(readlink "$destination")"

      if [ "$current_target" = "$skill" ]; then
        echo "[OK] $name already linked"
      else
        echo "[SKIP] $name already links to another location:"
        echo "       $current_target"
        echo "       Expected: $skill"
      fi

      continue
    fi

    if [ -e "$destination" ]; then
      echo "[SKIP] $name already exists at $destination"
      continue
    fi

    ln -s "$skill" "$destination"
    echo "[LINKED] $name"
  done
}

link_skills "Agents" "$AGENTS_DIR"

if [ -d "$HOME/.codex" ]; then
  link_skills "Codex" "$CODEX_DIR"
else
  echo "Codex directory not found; skipping Codex."
fi

if [ -d "$HOME/.cursor" ]; then
  link_skills "Cursor" "$CURSOR_DIR"
else
  echo "Cursor directory not found; skipping Cursor."
fi

if [ -d "$HOME/.claude" ]; then
  link_skills "Claude" "$CLAUDE_DIR"
else
  echo "Claude directory not found; skipping Claude."
fi

echo
echo "Setup complete."
