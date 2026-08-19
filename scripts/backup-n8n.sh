#!/usr/bin/env bash
set -Eeuo pipefail
umask 077

readonly LYVOX_ROOT="${LYVOX_ROOT:-/opt/lyvox}"
readonly N8N_DIR="${N8N_DIR:-$LYVOX_ROOT/n8n}"
readonly BACKUP_DIR="${BACKUP_DIR:-$N8N_DIR/backups}"
timestamp="$(date -u +%Y%m%dT%H%M%SZ)"
archive="${BACKUP_PATH:-$BACKUP_DIR/n8n-$timestamp.tar.gz}"

log() { printf '[backup-n8n] %s\n' "$*"; }
die() { printf '[backup-n8n] ERROR: %s\n' "$*" >&2; exit 1; }
as_root() { if (( EUID == 0 )); then "$@"; else command sudo "$@"; fi; }

was_running=false
restart_n8n() {
  if [[ "$was_running" == true ]]; then
    as_root docker compose --project-directory "$N8N_DIR" -f "$N8N_DIR/docker-compose.yml" start n8n >/dev/null
  fi
}
trap restart_n8n EXIT

as_root test -f "$N8N_DIR/.env" || die "$N8N_DIR/.env não encontrado."
as_root test -d "$N8N_DIR/data" || die "$N8N_DIR/data não encontrado."
as_root install -d -m 0700 "$BACKUP_DIR"
if as_root test -f "$N8N_DIR/docker-compose.yml" \
  && as_root docker compose --project-directory "$N8N_DIR" -f "$N8N_DIR/docker-compose.yml" ps -q n8n | grep -q . \
  && [[ "$(as_root docker inspect -f '{{.State.Running}}' lyvox-n8n 2>/dev/null || true)" == true ]]; then
  was_running=true
  as_root docker compose --project-directory "$N8N_DIR" -f "$N8N_DIR/docker-compose.yml" stop n8n >/dev/null
  log "n8n pausado brevemente para backup SQLite consistente."
fi
as_root tar -C "$LYVOX_ROOT" -czf "$archive" n8n/.env n8n/data
as_root chmod 0600 "$archive"
archive_hash="$(as_root sha256sum "$archive" | awk '{print $1}')"
printf '%s  %s\n' "$archive_hash" "$(basename -- "$archive")" | as_root tee "$archive.sha256" >/dev/null
as_root chmod 0600 "$archive.sha256"
restart_n8n
was_running=false
log "backup criado: $archive"
log "ATENÇÃO: contém encryption key e banco de credenciais; armazene criptografado e fora da VPS."
