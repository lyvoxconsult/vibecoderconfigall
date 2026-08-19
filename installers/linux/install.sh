#!/usr/bin/env bash
set -Eeuo pipefail
readonly INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export REPO_ROOT="${REPO_ROOT:-$(cd "$INSTALLER_DIR/../.." && pwd)}"
export LYVOX_ROOT="${LYVOX_ROOT:-/opt/lyvox}"
steps=(install-tools.sh install-docker.sh)
if [[ "${INSTALL_DEV_ENV:-1}" == 1 ]]; then
  steps+=(install-node.sh install-python.sh install-extensions.sh configure-git.sh configure-codex.sh configure-antigravity.sh)
else
  echo '[install] ferramentas de desktop/IDE omitidas (INSTALL_DEV_ENV=0)'
fi
steps+=(setup-directories.sh setup-skills.sh setup-docs.sh install-n8n.sh setup-firewall.sh validate.sh)
for step in "${steps[@]}"; do printf '[install] executando %s\n' "$step"; bash "$INSTALLER_DIR/$step"; done
