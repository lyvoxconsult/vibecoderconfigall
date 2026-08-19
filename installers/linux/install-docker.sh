#!/usr/bin/env bash
set -Eeuo pipefail
run_root() { if [[ $EUID -eq 0 ]]; then "$@"; else sudo "$@"; fi; }
if command -v docker >/dev/null 2>&1 && docker compose version >/dev/null 2>&1; then echo "[docker] Docker e Compose plugin já instalados"; exit 0; fi
# shellcheck disable=SC1091
. /etc/os-release
case "$ID" in ubuntu|debian) ;; *) echo "[docker] somente Ubuntu/Debian" >&2; exit 1;; esac
arch="$(dpkg --print-architecture)"
run_root install -m 0755 -d /etc/apt/keyrings
tmp_key="$(mktemp)"; trap 'rm -f "$tmp_key"' EXIT
curl -fsSL "https://download.docker.com/linux/$ID/gpg" -o "$tmp_key"
run_root install -m 0644 "$tmp_key" /etc/apt/keyrings/docker.asc
printf 'deb [arch=%s signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/%s %s stable\n' "$arch" "$ID" "$VERSION_CODENAME" | run_root tee /etc/apt/sources.list.d/docker.list >/dev/null
run_root apt-get update
run_root env DEBIAN_FRONTEND=noninteractive apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
run_root systemctl enable --now docker
target_user="${SUDO_USER:-${USER:-}}"
if [[ -n "$target_user" && "$target_user" != root ]]; then run_root usermod -aG docker "$target_user"; echo "[docker] $target_user adicionado ao grupo docker; novo login pode ser necessário"; fi
docker --version; docker compose version
