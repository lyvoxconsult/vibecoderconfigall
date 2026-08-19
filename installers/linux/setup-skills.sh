#!/usr/bin/env bash
set -Eeuo pipefail
REPO_ROOT="${REPO_ROOT:-$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)}"; LYVOX_ROOT="${LYVOX_ROOT:-/opt/lyvox}"
bash "$REPO_ROOT/skills/install-skills.sh" --target "$LYVOX_ROOT/skills"
echo "[skills] manifest e catálogo curado instalados; conteúdo de skills exige origem, dry-run e aprovação explícitos"
