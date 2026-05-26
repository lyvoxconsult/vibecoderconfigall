#!/bin/bash

# ==============================================================================
# INSTALADOR DE EXTENSÕES VS CODE (Linux) - install-extensions.sh
# ==============================================================================
# Instala em lote as extensões essenciais e recomendadas mapeadas do seu ambiente.
# ==============================================================================

echo -e "\e[32m🔍 Verificando presença da CLI do VS Code (code)...\e[0m"
if ! command -v code &> /dev/null; then
    echo -e "\e[33m⚠️ Comando 'code' não encontrado no PATH. Pulando sincronização de extensões.\e[0m"
    exit 0
fi

# Lista de extensões fundamentais mapeadas do seu ambiente original
EXTENSIONS=(
    "anthropic.claude-code"
    "biomejs.biome"
    "christian-kohler.path-intellisense"
    "davidanson.vscode-markdownlint"
    "dbaeumer.vscode-eslint"
    "dracula-theme.theme-dracula"
    "dsznajder.es7-react-js-snippets"
    "eamodio.gitlens"
    "editorconfig.editorconfig"
    "esbenp.prettier-vscode"
    "fhgffy.antigravity-auto-accept"
    "ms-python.python"
    "ms-vscode-remote.remote-wsl"
    "ms-vscode.cpptools"
    "pkief.material-icon-theme"
    "streetsidesoftware.code-spell-checker"
    "usernamehw.errorlens"
)

echo -e "\e[36m🚀 Iniciando instalação em lote de ${#EXTENSIONS[@]} extensões...\e[0m"

for ext in "${EXTENSIONS[@]}"; do
    echo -e "\e[33m📦 Instalando/Atualizando extensão: $ext...\e[0m"
    code --install-extension "$ext" --force &> /dev/null
    if [ $? -eq 0 ]; then
        echo -e "\e[32m✅ $ext instalada com sucesso!\e[0m"
    else
        echo -e "\e[33m⚠️ Falha ao instalar $ext.\e[0m"
    fi
done

echo -e "\e[32m✅ Sincronização de extensões concluída!\e[0m"
