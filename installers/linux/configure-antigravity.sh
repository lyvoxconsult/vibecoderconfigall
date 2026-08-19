#!/usr/bin/env bash
set -Eeuo pipefail

# ==============================================================================
# CONFIGURADOR DE INTELIGÊNCIA DO ANTIGRAVITY (Linux) - configure-antigravity.sh
# ==============================================================================

INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$(dirname "$INSTALLER_DIR")")"

ANTIGRAVITY_CONFIG_DIR="$HOME/.gemini/config"
PROMPT_SOURCE="$REPO_ROOT/agents/antigravity-global-prompt.md"

echo -e "\e[33m🚀 Configurando contexto e prompts globais do Antigravity...\e[0m"

if [ -f "$PROMPT_SOURCE" ]; then
    mkdir -p "$ANTIGRAVITY_CONFIG_DIR"
    if [[ -f "$ANTIGRAVITY_CONFIG_DIR/antigravity-global-prompt.md" ]] && ! cmp -s "$PROMPT_SOURCE" "$ANTIGRAVITY_CONFIG_DIR/antigravity-global-prompt.md"; then
        cp -p "$ANTIGRAVITY_CONFIG_DIR/antigravity-global-prompt.md" "$ANTIGRAVITY_CONFIG_DIR/antigravity-global-prompt.md.bak.$(date -u +%Y%m%dT%H%M%SZ)"
    fi
    cp "$PROMPT_SOURCE" "$ANTIGRAVITY_CONFIG_DIR/antigravity-global-prompt.md"
    echo -e "\e[32m✅ Prompt global de sistema injetado com sucesso no Antigravity!\e[0m"
else
    echo -e "\e[33m⚠️ Arquivo de prompt global não encontrado em: $PROMPT_SOURCE\e[0m"
fi
