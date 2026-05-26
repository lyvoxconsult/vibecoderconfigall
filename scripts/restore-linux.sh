#!/bin/bash

# ==============================================================================
# SCRIPT DE RESTAURAÇÃO DE CONFIGURAÇÕES (Bash/Linux) - restore-linux.sh
# ==============================================================================
# Injeta as configurações higienizadas do repositório para as pastas de
# usuário locais ativas do sistema operacional (ex: VS Code).
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
if [[ "$REPO_ROOT" == */scripts ]]; then
    REPO_ROOT="$(dirname "$REPO_ROOT")"
fi

echo -e "\e[36m====================================================\e[0m"
echo -e "\e[36m🔄  Iniciando restauração de configurações locais no Linux...\e[0m"
echo -e "\e[36m====================================================\e[0m"

# 1. Restaurar Configurações do VS Code
vscode_config_dir="$HOME/.config/Code/User"
vscode_settings_path="$vscode_config_dir/settings.json"
repo_settings_path="$REPO_ROOT/configs/vscode/settings.json"

if [ -f "$repo_settings_path" ]; then
    mkdir -p "$vscode_config_dir"
    
    # Backup da configuração atual
    if [ -f "$vscode_settings_path" ]; then
        cp "$vscode_settings_path" "$vscode_settings_path.bak"
        echo -e "\e[33m💾 Backup do settings.json local atual realizado em: $vscode_settings_path.bak\e[0m"
    fi
    
    # Copiar do repositório
    cp "$repo_settings_path" "$vscode_settings_path"
    echo -e "\e[32m✅ Configurações do VS Code injetadas com sucesso em: $vscode_settings_path\e[0m"
else
    echo -e "\e[31m❌ Erro: Configuração de settings.json não encontrada no repositório.\e[0m"
fi

# 2. Injetar Configurações do Antigravity
antigravity_dir="$HOME/.gemini/config"
repo_antigravity_path="$REPO_ROOT/configs/antigravity/config.example.json"
target_antigravity_path="$antigravity_dir/config.json"

if [ -f "$repo_antigravity_path" ]; then
    mkdir -p "$antigravity_dir"
    
    # Copiar caso não exista
    if [ ! -f "$target_antigravity_path" ]; then
        cp "$repo_antigravity_path" "$target_antigravity_path"
        echo -e "\e[32m✅ Configurações de permissões do Antigravity criadas em: $target_antigravity_path\e[0m"
    else
        echo -e "\e[33mℹ️ Arquivo config.json do Antigravity já existe. Pulando cópia.\e[0m"
    fi
fi

# 3. Rodar validação
echo -e "\e[32m🔍 Executando validação de integridade pós-restauração...\e[0m"
bash "$REPO_ROOT/installers/linux/validate.sh"

echo -e "\e[36m====================================================\e[0m"
echo -e "\e[32m🎉  Restauração e injeção de configurações concluídas com sucesso!\e[0m"
echo -e "\e[36m====================================================\e[0m"
