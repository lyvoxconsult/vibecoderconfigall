#!/bin/bash

# ==============================================================================
# CONFIGURADOR DE PYTHON E UV (Linux) - install-python.sh
# ==============================================================================
# Garante a presença do Python 3 e instala o gerenciador de pacotes uv.
# ==============================================================================

echo -e "\e[32m🔍 Verificando se o Python está instalado...\e[0m"

if ! command -v python3 &> /dev/null; then
    echo -e "\e[33m🚀 Python 3 não encontrado! Instalando via apt...\e[0m"
    sudo apt-get install -y python3 python3-pip python3-venv
    echo -e "\e[32m✅ Python 3 e pip instalados com sucesso!\e[0m"
else
    python_ver=$(python3 --version)
    echo -e "\e[32m✅ Python 3 já presente no sistema ($python_ver).\e[0m"
fi

# Instalar uv
echo -e "\e[32m🔍 Verificando se o gerenciador uv está instalado...\e[0m"
if ! command -v uv &> /dev/null; then
    echo -e "\e[33m🚀 uv não encontrado! Instalando o gerenciador de pacotes uv via script oficial...\e[0m"
    curl -LsSf https://astral.sh/uv/install.sh | sh
    # Adicionar uv ao path atual para uso imediato no script
    export PATH="$HOME/.local/bin:$PATH"
    echo -e "\e[32m✅ uv instalado com sucesso!\e[0m"
else
    echo -e "\e[32m✅ uv já presente no sistema.\e[0m"
fi
