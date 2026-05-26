#!/bin/bash

# ==============================================================================
# ORQUESTRADOR PRINCIPAL DE INSTALAÇÃO (Linux) - install.sh
# ==============================================================================
# Gerencia e executa os instaladores específicos em sequência para provisionar
# o seu ambiente de desenvolvimento no Linux (Ubuntu/Debian) ou WSL.
# ==============================================================================

INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$INSTALLER_DIR"
if [[ "$REPO_ROOT" == */installers/linux ]]; then
    REPO_ROOT="$(dirname "$(dirname "$REPO_ROOT")")"
fi

echo -e "\e[36m====================================================\e[0m"
echo -e "\e[36m🪐  Iniciando Provisionamento do Ambiente vibecoderconfigall no Linux...\e[0m"
echo -e "\e[36m====================================================\e[0m"

# Dando permissão de execução interna
chmod +x "$INSTALLER_DIR"/*.sh

# 1. Executar instalador de Ferramentas / CLIs (apt/curl)
echo -e "\n\e[36m🚀 [Passo 1/7] Instalando CLIs e Utilitários de Desenvolvimento...\e[0m"
bash "$INSTALLER_DIR/install-tools.sh"

# 2. Setup do Node.js
echo -e "\n\e[36m🚀 [Passo 2/7] Configurando ecossistema Node.js (LTS & pnpm)...\e[0m"
bash "$INSTALLER_DIR/install-node.sh"

# 3. Setup do Python
echo -e "\n\e[36m🚀 [Passo 3/7] Configurando ecossistema Python (pip & uv)...\e[0m"
bash "$INSTALLER_DIR/install-python.sh"

# 4. Instalar Extensões no VS Code
echo -e "\n\e[36m🚀 [Passo 4/7] Sincronizando extensões de IDE...\e[0m"
bash "$INSTALLER_DIR/install-extensions.sh"

# 5. Configurar o Git Global
echo -e "\n\e[36m🚀 [Passo 5/7] Otimizando configurações globais do Git...\e[0m"
bash "$INSTALLER_DIR/configure-git.sh"

# 6. Configurações de Agentes (Codex & Antigravity)
echo -e "\n\e[36m🚀 [Passo 6/7] Injetando regras de inteligência de Agentes...\e[0m"
bash "$INSTALLER_DIR/configure-codex.sh"
bash "$INSTALLER_DIR/configure-antigravity.sh"

# 7. Validação Final do Ambiente
echo -e "\n\e[36m🚀 [Passo 7/7] Validando integridade operacional do sistema...\e[0m"
bash "$INSTALLER_DIR/validate.sh"

echo -e "\e[36m====================================================\e[0m"
echo -e "\e[32m🎉  Provisionamento concluído! Seu ambiente está pronto para uso.\e[0m"
echo -e "\e[32mPor favor, siga as etapas manuais indicadas no relatório.\e[0m"
echo -e "\e[36m====================================================\e[0m"
