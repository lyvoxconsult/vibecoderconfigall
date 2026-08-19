#!/usr/bin/env bash
set -Eeuo pipefail

# ==============================================================================
# CONFIGURADOR GLOBAL DO GIT (Linux) - configure-git.sh
# ==============================================================================
# Otimiza o comportamento global do Git e configura aliases corporativos.
# ==============================================================================

echo -e "\e[32m🔍 Verificando presença do Git...\e[0m"
if ! command -v git &> /dev/null; then
    echo -e "\e[31m❌ Git não encontrado! Instale o Git antes de rodar o configure-git.\e[0m"
    exit 1
fi

echo -e "\e[33m🚀 Aplicando otimizações globais de comportamento do Git...\e[0m"

# Otimizações
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global core.autocrlf input
git config --global core.editor "code --wait"

# Aliases
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

echo -e "\e[32m✅ Aliases e comportamento globais do Git configurados no Linux!\e[0m"
echo -e "\e[33mNota: A identidade de usuário (user.name e user.email) deve ser configurada manualmente.\e[0m"
