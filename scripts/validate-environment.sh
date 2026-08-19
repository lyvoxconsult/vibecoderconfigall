#!/usr/bin/env bash
set -Eeuo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"; LYVOX_ROOT="${LYVOX_ROOT:-/opt/lyvox}"; errors=0
for command_name in curl git jq rsync openssl docker; do if command -v "$command_name" >/dev/null 2>&1; then printf '[validate] ok: %s\n' "$command_name"; else printf '[validate] missing: %s\n' "$command_name" >&2; ((errors+=1)); fi; done
if command -v docker >/dev/null 2>&1 && ! docker compose version >/dev/null 2>&1; then echo "[validate] Docker Compose plugin ausente" >&2; ((errors+=1)); fi
for path in "$LYVOX_ROOT" "$LYVOX_ROOT/n8n" "$LYVOX_ROOT/backups"; do [[ -d "$path" ]] || { echo "[validate] diretório ausente: $path" >&2; ((errors+=1)); }; done
if [[ -f "$LYVOX_ROOT/n8n/.env" ]]; then key="$(sed -n 's/^N8N_ENCRYPTION_KEY=//p' "$LYVOX_ROOT/n8n/.env" | tail -n1)"; [[ ${#key} -ge 32 && "$key" != *CHANGE_ME* ]] || { echo "[validate] encryption key inválida" >&2; ((errors+=1)); }; fi
if command -v docker >/dev/null 2>&1 && [[ -f "$LYVOX_ROOT/n8n/docker-compose.yml" ]]; then (cd "$LYVOX_ROOT/n8n" && docker compose config --quiet) || ((errors+=1)); fi
if [[ "${START_N8N:-1}" == 1 && -f "$LYVOX_ROOT/n8n/.env" ]]; then bash "$REPO_ROOT/scripts/healthcheck.sh" || ((errors+=1)); else echo "[validate] healthcheck runtime omitido (START_N8N=0)"; fi
bash "$REPO_ROOT/scripts/check-secrets.sh" || ((errors+=1))
((errors == 0)) || { echo "[validate] $errors erro(s)" >&2; exit 1; }
echo "[validate] ambiente válido"
