#!/bin/bash

# ==============================================================================
# SCRIPT DE RE-ESCANEAMENTO E BACKUP DO AMBIENTE ATUAL (Bash/Linux)
# ==============================================================================
# Este script varre o sistema do usuário para atualizar os inventários de
# ferramentas, as extensões do VS Code e as configurações globais de forma segura.
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
if [[ "$REPO_ROOT" == */scripts ]]; then
    REPO_ROOT="$(dirname "$REPO_ROOT")"
fi

echo -e "\e[36m====================================================\e[0m"
echo -e "\e[36m🔄  Iniciando re-escaneamento e atualização do backup de ambiente...\e[0m"
echo -e "\e[36m====================================================\e[0m"

# 1. Atualizar Extensões do VS Code
echo -e "\e[32m🔍 Rastreando extensões instaladas no VS Code...\e[0m"
extensions_file="$REPO_ROOT/reports/extensions-detected.md"

if command -v code &> /dev/null; then
    echo "# 🔍 Relatório de Extensões do VS Code Detectadas" > "$extensions_file"
    echo "Atualizado em: $(date '+%d-%m-%Y %H:%M:%S')" >> "$extensions_file"
    echo -e "\nAbaixo estão listadas todas as extensões detectadas de forma ativa no seu ambiente de trabalho:\n" >> "$extensions_file"
    
    code --list-extensions | while read -r ext; do
        echo "- $ext" >> "$extensions_file"
    done
    echo -e "\e[32m✅ Relatório de extensões detectadas atualizado: $extensions_file\e[0m"
else
    echo -e "\e[33m⚠️ VS Code CLI não encontrado. Pulando backup de extensões.\e[0m"
fi

# 2. Rastrear Versões de Ferramentas Ativas
echo -e "\e[32m🔍 Mapeando versões de ferramentas ativas...\e[0m"
tools_file="$REPO_ROOT/reports/tools-detected.md"

node_ver=$(node -v 2>/dev/null || echo "Não instalado")
npm_ver=$(npm -v 2>/dev/null || echo "Não instalado")
git_ver=$(git --version 2>/dev/null || echo "Não instalado")
python_ver=$(python3 --version 2>/dev/null || echo "Não instalado")

cat <<EOF > "$tools_file"
# 🛠️ Relatório de Ferramentas Detectadas no Ambiente

Atualizado em: $(date '+%d-%m-%Y %H:%M:%S')

Abaixo estão listadas as ferramentas fundamentais detectadas no seu sistema:

- **Node.js:** $node_ver
- **npm:** $npm_ver
- **Git:** $git_ver
- **Python:** $python_ver
EOF
echo -e "\e[32m✅ Relatório de ferramentas ativas atualizado: $tools_file\e[0m"

# 3. Rodar varredura preventiva contra segredos antes de finalizar
echo -e "\e[32m🛡️  Executando varredura interna contra segredos...\e[0m"
bash "$SCRIPT_DIR/check-secrets.sh"

echo -e "\e[36m====================================================\e[0m"
echo -e "\e[32m🎉  Backup e sincronização de ambiente concluídos com sucesso!\e[0m"
echo -e "\e[36m====================================================\e[0m"
