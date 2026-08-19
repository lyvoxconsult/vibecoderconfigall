#!/usr/bin/env bash
set -Eeuo pipefail
LYVOX_ROOT="${LYVOX_ROOT:-/opt/lyvox}"; echo "LYVOX_ROOT=$LYVOX_ROOT"
docker_cmd=()
if command -v docker >/dev/null 2>&1; then
  docker --version; docker compose version
  if docker info >/dev/null 2>&1; then docker_cmd=(docker); elif command -v sudo >/dev/null 2>&1 && sudo docker info >/dev/null 2>&1; then docker_cmd=(sudo docker); fi
else echo "Docker: não instalado"; fi
if [[ -f "$LYVOX_ROOT/n8n/docker-compose.yml" && ${#docker_cmd[@]} -gt 0 ]]; then (cd "$LYVOX_ROOT/n8n" && "${docker_cmd[@]}" compose ps); else echo "n8n: não preparado ou daemon inacessível"; fi
printf 'docs=%s skills=%s backups=%s\n' "$LYVOX_ROOT/docs" "$LYVOX_ROOT/skills" "$LYVOX_ROOT/backups"
