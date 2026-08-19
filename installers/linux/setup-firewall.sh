#!/usr/bin/env bash
set -Eeuo pipefail
run_root() { if [[ $EUID -eq 0 ]]; then "$@"; else sudo "$@"; fi; }
if [[ "${CONFIGURE_UFW:-0}" != 1 ]]; then echo "[firewall] não alterado (defina CONFIGURE_UFW=1 para permitir SSH e ativar UFW)"; exit 0; fi
ssh_port="${SSH_PORT:-22}"; [[ "$ssh_port" =~ ^[0-9]+$ && "$ssh_port" -ge 1 && "$ssh_port" -le 65535 ]] || { echo "[firewall] SSH_PORT inválida (use 1-65535)" >&2; exit 1; }
run_root ufw allow "$ssh_port/tcp"; run_root ufw --force enable; run_root ufw status verbose
