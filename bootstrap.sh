#!/usr/bin/env bash
set -Eeuo pipefail

readonly REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LYVOX_ROOT="${LYVOX_ROOT:-/opt/lyvox}"
export INSTALL_DEV_ENV="${INSTALL_DEV_ENV:-0}"
log() { printf '[bootstrap] %s\n' "$*"; }
die() { printf '[bootstrap] ERROR: %s\n' "$*" >&2; exit 1; }
trap 'die "falha na linha $LINENO"' ERR
[[ -r /etc/os-release ]] || die "somente Ubuntu/Debian são suportados"
# shellcheck disable=SC1091
. /etc/os-release
case "${ID:-}:${ID_LIKE:-}" in ubuntu:*|debian:*|*:ubuntu*|*:debian*) ;; *) die "distribuição não suportada: ${PRETTY_NAME:-desconhecida}";; esac
command -v sudo >/dev/null 2>&1 || [[ $EUID -eq 0 ]] || die "sudo é obrigatório para usuário não-root"
log "raiz Lyvox: $LYVOX_ROOT"
bash "$REPO_ROOT/installers/linux/install.sh"
log "concluído; confira o status abaixo"
bash "$REPO_ROOT/scripts/print-status.sh"
