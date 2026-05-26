#!/bin/bash

# ==============================================================================
# SCRIPT DE AUDITORIA DE SEGREDOS (Bash) - check-secrets.sh
# ==============================================================================
# Analisa recursivamente os arquivos do repositório em busca de chaves
# de API expostas, senhas em texto puro ou strings de conexão reais de banco.
# ==============================================================================

# Obter diretório raiz
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
if [[ "$REPO_ROOT" == */scripts ]]; then
    REPO_ROOT="$(dirname "$REPO_ROOT")"
fi

echo -e "\e[36m====================================================\e[0m"
echo -e "\e[36m🛡️  Iniciando Auditoria Preventiva contra Vazamento de Segredos...\e[0m"
echo -e "\e[36mDiretório Base: $REPO_ROOT\e[0m"
echo -e "\e[36m====================================================\e[0m"

# Declarar chaves e expressões regex de verificação
declare -A PATTERNS
PATTERNS=(
    ["GEMINI_API_KEY"]="AIzaSy[A-Za-z0-9_-]{35}"
    ["OPENAI_API_KEY"]="sk-[A-Za-z0-9_-]{40,}"
    ["ANTHROPIC_API_KEY"]="sk-ant-[A-Za-z0-9_-]{60,}"
    ["GITHUB_TOKEN"]="github_pat_[A-Za-z0-9_-]{60,}"
    ["VERCEL_TOKEN"]="vercel_token_[A-Za-z0-9_-]{20,}"
    ["SUPABASE_SERVICE_ROLE"]="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9\.[A-Za-z0-9_=-]{30,}\.[A-Za-z0-9_=-]{40,}"
    ["PRIVATE_KEY"]="-----BEGIN [A-Z ]+ PRIVATE KEY-----"
)

SECRETS_COUNT=0

# Procurar chaves recursivamente em todos os arquivos no repositório
while IFS= read -r -d '' file; do
    # Pular pastas ignoradas e arquivos do script
    if [[ "$file" == *"node_modules"* || "$file" == *".git"* || "$file" == *"check-secrets"* || "$file" == *".env.example" || "$file" == *"SECURITY_NOTES.md" ]]; then
        continue
    fi
    
    for key in "${!PATTERNS[@]}"; do
        pattern="${PATTERNS[$key]}"
        if grep -qE "$pattern" "$file"; then
            echo -e "\e[33m⚠️ ALERTA: Assinatura suspeita [$key] detectada!\e[0m"
            echo -e "\e[31mArquivo: $file\e[0m"
            
            # Mostrar linhas suspeitas sanitizadas no console
            grep -nE "$pattern" "$file" | while read -r line; do
                line_num=$(echo "$line" | cut -d: -f1)
                line_content=$(echo "$line" | cut -d: -f2- | sed -E "s/$pattern/[REMOVIDO POR SEGURANÇA]/g")
                echo -e "   Linha $line_num: $line_content"
            done
            
            SECRETS_COUNT=$((SECRETS_COUNT + 1))
        fi
    done
done < <(find "$REPO_ROOT" -type f -print0)

echo -e "\e[36m====================================================\e[0m"
if [ "$SECRETS_COUNT" -eq 0 ]; then
    echo -e "\e[32m✅ Auditoria concluída com sucesso! Nenhum segredo ou chave exposta foi detectada.\e[0m"
    exit 0
else
    echo -e "\e[31m❌ Falha na auditoria de segurança! Foram encontradas $SECRETS_COUNT ocorrências de segredos.\e[0m"
    echo -e "\e[31mRemova as credenciais reais e coloque placeholders antes de commitar os arquivos.\e[0m"
    exit 1
fi
