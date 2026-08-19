#!/usr/bin/env bash
set -Eeuo pipefail
REPO_ROOT="${REPO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"; LYVOX_ROOT="${LYVOX_ROOT:-/opt/lyvox}"
install -d -m 0750 "$LYVOX_ROOT/docs" "$LYVOX_ROOT/docs/sanitized" "$LYVOX_ROOT/agent" "$LYVOX_ROOT/templates" "$LYVOX_ROOT/scripts"
rsync -a --exclude='sanitized/' --exclude='.env*' --exclude='*.key' --exclude='*.pem' "$REPO_ROOT/docs/" "$LYVOX_ROOT/docs/"
rsync -a --exclude='.env*' --exclude='*.key' --exclude='*.pem' "$REPO_ROOT/agents/" "$LYVOX_ROOT/agent/"
rsync -a --exclude='.env*' --exclude='*.key' --exclude='*.pem' "$REPO_ROOT/templates/" "$LYVOX_ROOT/templates/"
rsync -a --exclude='.env*' --exclude='*.key' --exclude='*.pem' "$REPO_ROOT/scripts/" "$LYVOX_ROOT/scripts/"
find "$LYVOX_ROOT/scripts" -maxdepth 1 -type f -name '*.sh' -exec chmod 0750 {} +
echo "[docs] documentação, templates, prompts e scripts operacionais instalados; sync do Core permanece manual/dry-run"
