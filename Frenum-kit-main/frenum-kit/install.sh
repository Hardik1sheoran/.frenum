#!/usr/bin/env bash
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
command -v node >/dev/null || { echo "Frenum requires Node.js 18+." >&2; exit 1; }
node -e 'if (+process.versions.node.split(".")[0] < 18) process.exit(1)' \
  || { echo "Frenum requires Node.js 18+." >&2; exit 1; }

for AGENT_DIR in "$HOME/.codex/skills" "$HOME/.claude/skills" "$HOME/.gemini/config/skills"; do
  for SKILL in frenum ponytail; do
    mkdir -p "$AGENT_DIR/$SKILL"
    cp "$KIT_DIR/skills/$SKILL/SKILL.md" "$AGENT_DIR/$SKILL/SKILL.md"
  done
done

BIN_DIR="${FRENUM_BIN_DIR:-$HOME/.local/bin}"
BIN="$BIN_DIR/frenum"
mkdir -p "$BIN_DIR"
if [[ -e "$BIN" && ! -L "$BIN" ]]; then
  echo "Refusing to replace existing file: $BIN" >&2
  exit 1
fi
if [[ -L "$BIN" && "$(readlink "$BIN")" != "$KIT_DIR/tools/frenum.mjs" ]]; then
  echo "Refusing to replace existing link: $BIN" >&2
  exit 1
fi
ln -sfn "$KIT_DIR/tools/frenum.mjs" "$BIN"

echo "Frenum installed offline."
echo "  CLI: $BIN"
echo "  Skills: Frenum + Ponytail for Codex, Claude Code, and Antigravity"
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  echo "  Add $BIN_DIR to PATH, or invoke $BIN directly."
fi
