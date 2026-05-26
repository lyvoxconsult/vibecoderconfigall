#!/bin/bash

# ==============================================================================
# INSTALADOR DE FERRAMENTAS E CLIS (Linux) - install-tools.sh
# ==============================================================================
# Instala CLIs e utilitários usando o gerenciador de pacotes apt (Ubuntu/Debian).
# O script é idempotente e valida dependências existentes.
# ==============================================================================

echo -e "\e[32m🔍 Verificando privilégios de execução (sudo)...\e[0m"
if [ "$EUID" -ne 0 ]; then
    echo -e "\e[33m⚠️  Nota: Script executado sem permissões de root/sudo.\e[0m"
    echo -e "Instalações de pacotes globais via apt podem solicitar sua senha ou falhar.\e[0m"
fi

# Lista de utilitários de sistema fundamentais
UTILITIES=(curl git build-essential docker-compose)

echo -e "\e[32m🚀 Atualizando repositório de pacotes...\e[0m"
sudo apt-get update -y &> /dev/null

for pkg in "${UTILITIES[@]}"; do
    echo -e "\e[32m🔍 Verificando presença de: $pkg...\e[0m"
    if dpkg -s "$pkg" &> /dev/null || command -v "$pkg" &> /dev/null; then
        echo -e "\e[32m   ✅ $pkg já está instalado.\e[0m"
    else
        echo -e "\e[33m   🚀 Instalando $pkg via apt...\e[0m"
        sudo apt-get install -y "$pkg"
    fi
done

# GitHub CLI
if ! command -v gh &> /dev/null; then
    echo -e "\e[33m🚀 gh (GitHub CLI) não encontrado. Instalando via repositório oficial...\e[0m"
    type -p curl >/dev/null || (sudo apt update && sudo apt install curl -y)
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt update \
    && sudo apt install gh -y
else
    echo -e "\e[32m✅ gh (GitHub CLI) já está presente no sistema.\e[0m"
fi
