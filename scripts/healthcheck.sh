#!/usr/bin/env bash
set -Eeuo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
LYVOX_ROOT="${LYVOX_ROOT:-/opt/lyvox}"; n8n_dir="${N8N_DIR:-$LYVOX_ROOT/n8n}"
if [[ ! -f "$n8n_dir/.env" && -f "$REPO_ROOT/docker/n8n/.env" ]]; then n8n_dir="$REPO_ROOT/docker/n8n"; fi
env_file="$n8n_dir/.env"
[[ -f "$env_file" ]] || { echo "[health] .env ausente" >&2; exit 1; }
bind="$(sed -n 's/^N8N_BIND_ADDRESS=//p' "$env_file" | tail -n1)"; port="$(sed -n 's/^N8N_PORT=//p' "$env_file" | tail -n1)"; bind="${bind:-127.0.0.1}"; port="${port:-5678}"
[[ "$bind" == 0.0.0.0 ]] && bind=127.0.0.1
retries="${HEALTHCHECK_RETRIES:-12}"
for ((attempt=1; attempt<=retries; attempt++)); do
  if curl --fail --silent --show-error --max-time 10 "http://$bind:$port/healthz" >/dev/null 2>&1; then
    echo "[health] n8n saudável em $bind:$port"
    exit 0
  fi
  ((attempt < retries)) && sleep 5
done
echo "[health] n8n não respondeu após $retries tentativa(s)" >&2
exit 1
