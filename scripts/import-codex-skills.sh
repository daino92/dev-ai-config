#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$HOME/.codex/skills"
DEST="$REPO_ROOT/shared/skills"

if [ ! -d "$SOURCE" ]; then
  echo "No Codex skills directory found at:"
  echo "  $SOURCE"
  exit 1
fi

mkdir -p "$DEST"

echo "Importing Codex skills..."
echo
echo "Source:"
echo "  $SOURCE"
echo
echo "Destination:"
echo "  $DEST"
echo

imported=0
skipped=0

for skill in "$SOURCE"/*; do
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

  cp -R "$skill" "$target"

  echo "[IMPORTED] $name"
  imported=$((imported + 1))
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
