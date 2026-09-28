#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$REPO_ROOT/shared/skills"
CODEX_DIR="$HOME/.codex/skills"
CLAUDE_DIR="$HOME/.claude/skills"

link_skills() {
  local target="$1"
  mkdir -p "$target"

  for skill in "$SOURCE"/*; do
    [ -d "$skill" ] || continue
    name="$(basename "$skill")"
    destination="$target/$name"

    if [ -e "$destination" ] || [ -L "$destination" ]; then
      echo "Skipping existing $destination"
      continue
    fi

    ln -s "$skill" "$destination"
    echo "Linked $name -> $destination"
  done
}

if [ -d "$HOME/.codex" ]; then
  link_skills "$CODEX_DIR"
else
  echo "Codex directory not found; skipping Codex links."
fi

if [ -d "$HOME/.claude" ]; then
  link_skills "$CLAUDE_DIR"
else
  echo "Claude directory not found; skipping Claude links."
fi

echo "Setup complete."
