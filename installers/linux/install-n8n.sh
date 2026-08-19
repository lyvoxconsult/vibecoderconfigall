#!/usr/bin/env bash
set -Eeuo pipefail
REPO_ROOT="${REPO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"; LYVOX_ROOT="${LYVOX_ROOT:-/opt/lyvox}"; n8n_dir="$LYVOX_ROOT/n8n"
docker_compose() { if docker info >/dev/null 2>&1; then docker compose "$@"; else sudo docker compose "$@"; fi; }
mkdir -p "$n8n_dir/data" "$n8n_dir/backups" "$n8n_dir/logs"
for source in docker-compose.yml .env.example; do src="$REPO_ROOT/docker/n8n/$source"; dst="$n8n_dir/$source"; if [[ ! -e "$dst" ]]; then install -m 0640 "$src" "$dst"; elif ! cmp -s "$src" "$dst"; then echo "[n8n] preservado arquivo existente: $dst"; fi; done
if [[ ! -f "$n8n_dir/.env" ]]; then install -m 0600 "$n8n_dir/.env.example" "$n8n_dir/.env"; key="$(openssl rand -hex 32)"; sed -i "s|^N8N_ENCRYPTION_KEY=.*$|N8N_ENCRYPTION_KEY=$key|" "$n8n_dir/.env"; echo "[n8n] .env local criado com encryption key aleatória"; fi
chmod 0600 "$n8n_dir/.env"
key="$(sed -n 's/^N8N_ENCRYPTION_KEY=//p' "$n8n_dir/.env" | tail -n1)"; [[ ${#key} -ge 32 && "$key" != *CHANGE_ME* ]] || { echo "[n8n] N8N_ENCRYPTION_KEY obrigatória (mínimo 32 caracteres)" >&2; exit 1; }
if [[ "${START_N8N:-1}" == 1 ]]; then (cd "$n8n_dir" && docker_compose pull && docker_compose up -d); else echo "[n8n] preparado sem iniciar (START_N8N=0)"; fi
