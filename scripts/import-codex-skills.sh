#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DEST="$REPO_ROOT/shared/skills"

mkdir -p "$DEST"

echo "Importing local skills into $DEST"

imported=0
skipped=0

for source in "$HOME/.agents/skills" "$HOME/.codex/skills"; do
  [ -d "$source" ] || continue
  echo "Source: $source"
  for skill in "$source"/*; do
    [ -d "$skill" ] || continue

    name="$(basename "$skill")"
    target="$DEST/$name"

    if [ -L "$skill" ]; then
      echo "[SKIP] $name is already a symbolic link"
      skipped=$((skipped + 1))
      continue
    fi

    if [ -e "$target" ]; then
      echo "[SKIP] $name already exists in shared/skills"
      skipped=$((skipped + 1))
      continue
    fi

    rsync -a --exclude='__pycache__/' --exclude='*.pyc' "$skill/" "$target/"

    echo "[IMPORTED] $name"
    imported=$((imported + 1))
  done
done

echo
echo "Import complete."
echo
echo "Imported: $imported"
echo "Skipped:  $skipped"
echo
echo "IMPORTANT:"
echo "Review all imported files before committing."
echo "Check for:"
echo "- secrets"
echo "- API keys"
echo "- company-specific information"
echo "- absolute machine paths"
echo
echo "Then commit them on a feature branch and open a PR to develop."
