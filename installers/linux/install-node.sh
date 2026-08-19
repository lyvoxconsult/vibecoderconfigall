#!/usr/bin/env bash
set -Eeuo pipefail

# ==============================================================================
# CONFIGURADOR DE NODE.JS E PNPM (Linux) - install-node.sh
# ==============================================================================
# Garante o Node.js LTS e instala globalmente o gerenciador pnpm.
# ==============================================================================

echo -e "\e[32m🔍 Verificando se o Node.js está instalado...\e[0m"

if ! command -v node &> /dev/null; then
    echo -e "\e[33m🚀 Node.js não encontrado! Instalando Node.js LTS via repositório NodeSource...\e[0m"
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
    echo -e "\e[32m✅ Node.js instalado com sucesso!\e[0m"
else
    node_ver=$(node -v)
    echo -e "\e[32m✅ Node.js já presente no sistema ($node_ver).\e[0m"
fi

# Instalar pnpm globalmente
echo -e "\e[32m🔍 Verificando se o pnpm está instalado...\e[0m"
if ! command -v pnpm &> /dev/null; then
    echo -e "\e[33m🚀 pnpm não encontrado! Instalando globalmente via npm...\e[0m"
    sudo npm install -g pnpm
    echo -e "\e[32m✅ pnpm instalado globalmente com sucesso!\e[0m"
else
    pnpm_ver=$(pnpm -v)
    echo -e "\e[32m✅ pnpm já presente no sistema (v$pnpm_ver).\e[0m"
fi
