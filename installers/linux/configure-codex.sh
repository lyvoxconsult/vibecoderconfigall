#!/usr/bin/env bash
set -Eeuo pipefail

# ==============================================================================
# CONFIGURADOR DE INTELIGÊNCIA DO CODEX (Linux) - configure-codex.sh
# ==============================================================================

INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$(dirname "$INSTALLER_DIR")")"

CODEX_LOCAL_DIR="$HOME/.codex"
PROMPT_SOURCE="$REPO_ROOT/agents/codex-global-prompt.md"

echo -e "\e[33m🚀 Configurando contexto e prompts globais do Codex...\e[0m"

if [ -f "$PROMPT_SOURCE" ]; then
    mkdir -p "$CODEX_LOCAL_DIR"
    if [[ -f "$CODEX_LOCAL_DIR/codex-global-prompt.md" ]] && ! cmp -s "$PROMPT_SOURCE" "$CODEX_LOCAL_DIR/codex-global-prompt.md"; then
        cp -p "$CODEX_LOCAL_DIR/codex-global-prompt.md" "$CODEX_LOCAL_DIR/codex-global-prompt.md.bak.$(date -u +%Y%m%dT%H%M%SZ)"
    fi
    cp "$PROMPT_SOURCE" "$CODEX_LOCAL_DIR/codex-global-prompt.md"
    echo -e "\e[32m✅ Prompt global de sistema injetado com sucesso no Codex!\e[0m"
else
    echo -e "\e[33m⚠️ Arquivo de prompt global não encontrado em: $PROMPT_SOURCE\e[0m"
fi
