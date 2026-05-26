#!/bin/bash

# ==============================================================================
# VALIDADOR OPERACIONAL DO AMBIENTE (Linux) - validate.sh
# ==============================================================================

INSTALLER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$(dirname "$INSTALLER_DIR")")"

echo -e "\e[36m====================================================\e[0m"
echo -e "\e[36m🔍  Validando Dependências e Conformidade do Ambiente Linux...\e[0m"
echo -e "\e[36m====================================================\e[0m"

ERRORS=0

# 1. Git
echo -e "\e[32m🔍 Testando Git...\e[0m"
if command -v git &> /dev/null; then
    echo -e "\e[32m✅ Git operando: $(git --version)\e[0m"
else
    echo -e "\e[31m❌ Git não respondendo!\e[0m"
    ERRORS=$((ERRORS + 1))
fi

# 2. Node.js
echo -e "\e[32m🔍 Testando Node.js...\e[0m"
if command -v node &> /dev/null; then
    echo -e "\e[32m✅ Node.js operando: $(node -v)\e[0m"
else
    echo -e "\e[31m❌ Node.js não respondendo!\e[0m"
    ERRORS=$((ERRORS + 1))
fi

# 3. npm
echo -e "\e[32m🔍 Testando npm...\e[0m"
if command -v npm &> /dev/null; then
    echo -e "\e[32m✅ npm operando: v$(npm -v)\e[0m"
else
    echo -e "\e[31m❌ npm não respondendo!\e[0m"
    ERRORS=$((ERRORS + 1))
fi

# 4. pnpm
echo -e "\e[32m🔍 Testando pnpm...\e[0m"
if command -v pnpm &> /dev/null; then
    echo -e "\e[32m✅ pnpm operando: v$(pnpm -v)\e[0m"
else
    echo -e "\e[33m⚠️ pnpm não encontrado. Instale via: npm install -g pnpm\e[0m"
fi

# 5. Python
echo -e "\e[32m🔍 Testando Python 3...\e[0m"
if command -v python3 &> /dev/null; then
    echo -e "\e[32m✅ Python operando: $(python3 --version)\e[0m"
else
    echo -e "\e[33m⚠️ Python 3 não encontrado.\e[0m"
fi

# 6. Docker
echo -e "\e[32m🔍 Testando Docker...\e[0m"
if command -v docker &> /dev/null; then
    echo -e "\e[32m✅ Docker operando: $(docker --version)\e[0m"
else
    echo -e "\e[33m⚠️ Docker não encontrado.\e[0m"
fi

# 7. VS Code settings
echo -e "\e[32m🔍 Verificando settings.json do VS Code...\e[0m"
if [ -f "$HOME/.config/Code/User/settings.json" ]; then
    echo -e "\e[32m✅ settings.json do VS Code presente e operando.\e[0m"
else
    echo -e "\e[33m⚠️ settings.json não encontrado em ~/.config/Code/User/\e[0m"
fi

echo -e "\e[36m====================================================\e[0m"
if [ "$ERRORS" -eq 0 ]; then
    echo -e "\e[32m✅ Ambiente Linux passou em todas as validações obrigatórias.\e[0m"
    exit 0
else
    echo -e "\e[31m❌ A validação encontrou $ERRORS problemas estruturais!\e[0m"
    exit 1
fi
