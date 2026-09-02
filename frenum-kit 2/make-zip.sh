#!/usr/bin/env bash
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUT="${1:-$KIT_DIR/frenum-kit.zip}"
[[ "$OUT" = /* ]] || OUT="$PWD/$OUT"
STAGE_ROOT="$(mktemp -d)"
trap 'rm -rf "$STAGE_ROOT"' EXIT

mkdir -p "$STAGE_ROOT/frenum-kit"
rsync -a \
  --exclude '.git' --exclude 'node_modules' --exclude '*.zip' \
  --exclude '.DS_Store' --exclude '*.bak' \
  "$KIT_DIR/" "$STAGE_ROOT/frenum-kit/"
(cd "$STAGE_ROOT" && zip -qr "$OUT" frenum-kit)
echo "Built $OUT (offline; no vendored or cloned dependencies)."
