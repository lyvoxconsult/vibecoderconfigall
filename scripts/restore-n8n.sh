#!/usr/bin/env bash
set -Eeuo pipefail
umask 077

readonly LYVOX_ROOT="${LYVOX_ROOT:-/opt/lyvox}"
readonly N8N_DIR="${N8N_DIR:-$LYVOX_ROOT/n8n}"
force=false
archive=''
log() { printf '[restore-n8n] %s\n' "$*"; }
die() { printf '[restore-n8n] ERROR: %s\n' "$*" >&2; exit 1; }
as_root() { if (( EUID == 0 )); then "$@"; else command sudo "$@"; fi; }

while (($#)); do
  case "$1" in
    --force) force=true ;;
    --) shift; archive="${1:-}"; break ;;
    -*) die "opção desconhecida: $1" ;;
    *) [[ -z "$archive" ]] || die "informe apenas um arquivo"; archive="$1" ;;
  esac
  shift
done
[[ "$force" == true ]] || die "restore é destrutivo; repita com --force"
[[ -n "$archive" && -f "$archive" ]] || die "informe um backup legível"
archive="$(realpath -- "$archive")"
[[ -f "$archive.sha256" ]] || die "sidecar obrigatório ausente: $archive.sha256"
expected_hash="$(as_root awk 'NR==1 {print $1}' "$archive.sha256")"
actual_hash="$(as_root sha256sum "$archive" | awk '{print $1}')"
[[ "$expected_hash" =~ ^[a-fA-F0-9]{64}$ && "$actual_hash" == "$expected_hash" ]] || die "checksum do backup inválido"
tar -tzf "$archive" >/dev/null || die "arquivo tar.gz inválido"
while IFS= read -r member; do
  [[ "$member" != /* ]] || die "archive contém caminho absoluto"
  [[ "/$member/" != *'/../'* ]] || die "archive contém path traversal"
  case "$member" in n8n/.env|n8n/data|n8n/data/*) ;; *) die "membro inesperado: $member" ;; esac
done < <(tar -tzf "$archive")
if tar -tvzf "$archive" | awk '$1 ~ /^[lh]/ {found=1} END {exit !found}'; then die "archive contém link simbólico ou hard link"; fi

tmp_dir="$(mktemp -d)"; trap 'rm -rf -- "$tmp_dir"' EXIT
tar -xzf "$archive" -C "$tmp_dir" --no-same-owner --no-same-permissions
[[ -f "$tmp_dir/n8n/.env" && -d "$tmp_dir/n8n/data" ]] || die "backup incompleto"
if as_root test -f "$N8N_DIR/.env" && as_root test -d "$N8N_DIR/data"; then
  safety_dir="${SAFETY_BACKUP_DIR:-$LYVOX_ROOT/backups/pre-restore}"
  as_root env LYVOX_ROOT="$LYVOX_ROOT" N8N_DIR="$N8N_DIR" BACKUP_DIR="$safety_dir" bash "${BASH_SOURCE[0]%/*}/backup-n8n.sh"
  log "backup preventivo criado"
fi
if as_root test -f "$N8N_DIR/docker-compose.yml"; then as_root docker compose --project-directory "$N8N_DIR" -f "$N8N_DIR/docker-compose.yml" down; fi
as_root install -d -m 0700 "$N8N_DIR/data"
as_root rsync -a --delete "$tmp_dir/n8n/data/" "$N8N_DIR/data/"
as_root install -m 0600 "$tmp_dir/n8n/.env" "$N8N_DIR/.env"
as_root chown -R 1000:1000 "$N8N_DIR/data"
log "restore concluído; revise o .env e suba o n8n explicitamente"
