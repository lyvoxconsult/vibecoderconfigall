#!/usr/bin/env bash
set -Eeuo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"; SKILLS_DIR="$REPO_ROOT/skills obrigatorias"; target="${LYVOX_ROOT:-<LOCAL_AGENT_ROOT>}/skills"
if [[ "${1:-}" == --target ]]; then target="${2:-}"; [[ -n "$target" ]] || exit 2; elif (($#)); then echo "uso: $0 [--target DIR]" >&2; exit 2; fi
mkdir -p "$target/mandatory" "$target/catalog"
for file in mandatory-10-skills.md README.md; do [[ -f "$SKILLS_DIR/$file" ]] && install -m 0640 -C "$SKILLS_DIR/$file" "$target/mandatory/$file"; done
[[ -f "$SKILLS_DIR/skills-manifest.json" ]] && install -m 0640 -C "$SKILLS_DIR/skills-manifest.json" "$target/skills-manifest.json"
for file in "$SKILLS_DIR"/*-skills.md; do [[ -e "$file" ]] || continue; install -m 0640 -C "$file" "$target/catalog/$(basename "$file")"; done
echo "[skills] catálogo instalado em $target sem copiar diretórios pessoais"
