#!/usr/bin/env bash
set -Eeuo pipefail
run_root() { if [[ $EUID -eq 0 ]]; then "$@"; else sudo "$@"; fi; }
[[ -r /etc/os-release ]] || { echo "[tools] /etc/os-release ausente" >&2; exit 1; }
# shellcheck disable=SC1091
. /etc/os-release
case "${ID:-}:${ID_LIKE:-}" in ubuntu:*|debian:*|*:ubuntu*|*:debian*) ;; *) echo "[tools] distro não suportada" >&2; exit 1;; esac
packages=(ca-certificates curl git unzip gnupg lsb-release jq rsync ufw openssl make build-essential tar gzip)
run_root apt-get update
run_root env DEBIAN_FRONTEND=noninteractive apt-get install -y "${packages[@]}"
echo "[tools] dependências base instaladas"
