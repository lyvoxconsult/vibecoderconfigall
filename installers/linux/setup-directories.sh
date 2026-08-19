#!/usr/bin/env bash
set -Eeuo pipefail
LYVOX_ROOT="${LYVOX_ROOT:-/opt/lyvox}"
run_root() { if [[ $EUID -eq 0 ]]; then "$@"; else sudo "$@"; fi; }
target_user="${SUDO_USER:-${USER:-root}}"; target_group="$(id -gn "$target_user")"
dirs=(agent n8n/data n8n/backups n8n/logs docs/lyvox-core docs/sanitized skills/agents skills/codex skills/mandatory prompts templates mcp scripts logs backups runtime)
for dir in "${dirs[@]}"; do run_root install -d -m 0750 -o "$target_user" -g "$target_group" "$LYVOX_ROOT/$dir"; done
run_root chown -R 1000:1000 "$LYVOX_ROOT/n8n/data" "$LYVOX_ROOT/n8n/logs"
echo "[directories] estrutura pronta em $LYVOX_ROOT"
