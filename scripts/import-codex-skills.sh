#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SOURCE="$HOME/.codex/skills"
DEST="$REPO_ROOT/shared/skills"

if [ ! -d "$SOURCE" ]; then
  echo "No Codex skills directory found at $SOURCE"
  exit 1
fi

mkdir -p "$DEST"

for skill in "$SOURCE"/*; do
  [ -d "$skill" ] || continue
  name="$(basename "$skill")"
  target="$DEST/$name"

  if [ -e "$target" ]; then
    echo "Skipping existing skill: $name"
    continue
  fi

  cp -R "$skill" "$target"
  echo "Imported: $name"
done

echo
echo "Import complete."
echo "Review the changes, then commit them on a feature branch and open a PR to develop."
