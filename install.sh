#!/usr/bin/env bash
set -euo pipefail

REPO="https://github.com/matiasbacelar98/mb-cursor-config.git"
CURSOR_DIR="$HOME/.cursor"
TMP_DIR=$(mktemp -d)
trap 'rm -rf "$TMP_DIR"' EXIT

echo "Downloading mb-cursor-config..."
git clone --depth 1 --quiet "$REPO" "$TMP_DIR/repo"

SRC="$TMP_DIR/repo/.cursor"

install_files() {
  local label="$1" src_dir="$2" dest_dir="$3"
  mkdir -p "$dest_dir"

  local count=0
  for f in "$src_dir"/*; do
    [ -e "$f" ] || continue
    cp -r "$f" "$dest_dir/"
    count=$((count + 1))
  done

  if [ "$count" -gt 0 ]; then
    echo "  $label: $count installed -> $dest_dir"
  else
    echo "  $label: nothing to install"
  fi
}

echo ""
install_files "Rules"    "$SRC/rules"    "$CURSOR_DIR/rules"
install_files "Skills"   "$SRC/skills"   "$CURSOR_DIR/skills"
install_files "Commands" "$SRC/commands" "$CURSOR_DIR/commands"

echo ""
echo "Done! Restart Cursor to pick up the changes."
