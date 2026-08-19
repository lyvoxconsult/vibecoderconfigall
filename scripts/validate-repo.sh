#!/usr/bin/env bash
set -Eeuo pipefail

# ==============================================================================
# SCRIPT DE VALIDAÇÃO DE INTEGRIDADE DO REPOSITÓRIO (Bash) - validate-repo.sh
# ==============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
if [[ "$REPO_ROOT" == */scripts ]]; then
    REPO_ROOT="$(dirname "$REPO_ROOT")"
fi

echo -e "\e[36m====================================================\e[0m"
echo -e "\e[36m🔍  Iniciando Validação de Integridade do Repositório...\e[0m"
echo -e "\e[36mDiretório Base: $REPO_ROOT\e[0m"
echo -e "\e[36m====================================================\e[0m"

# Lista de arquivos obrigatórios
MANDATORY_FILES=(
    "README.md"
    "QUICK_START.md"
    "SECURITY_NOTES.md"
    "CHANGELOG.md"
    ".gitignore"
    ".env.example"
    "bootstrap.sh"
    "docker/n8n/docker-compose.yml"
    "docker/n8n/.env.example"
    "installers/linux/install-docker.sh"
    "installers/linux/install-n8n.sh"
    "installers/linux/setup-directories.sh"
    "installers/linux/setup-docs.sh"
    "installers/linux/setup-firewall.sh"
    "installers/linux/setup-skills.sh"
    "scripts/validate-environment.sh"
    "scripts/backup-n8n.sh"
    "scripts/restore-n8n.sh"
    "scripts/healthcheck.sh"
    "scripts/print-status.sh"
    "scripts/update-from-git.sh"
    "scripts/update-skills.sh"
    "scripts/sync-lyvox-core-sanitized.sh"
    "skills/skills-manifest.json"
    "skills/install-skills.sh"
    "skills/sync-skills.sh"
    "docs/lyvox-core-allowlist.txt"
    "docs/lyvox-core-sync.md"
    "docs/knowledge-governance.md"
    "docs/n8n-agent-architecture.md"
    "docs/vps-security-hardening.md"
    "n8n/README.md"
    "reports/IMPLEMENTATION_REPORT.md"
    "reports/VALIDATION_REPORT.md"
    "reports/SECURITY_SCAN_REPORT.md"
    "reports/NEXT_STEPS.md"
    "configs/vscode/settings.json"
    "configs/antigravity/config.example.json"
    "mcp/mcp-config.example.json"
    "mcp/codex-mcp-config.example.toml"
    "agents/global-agent-rules.md"
    "agents/antigravity-global-prompt.md"
    "agents/codex-global-prompt.md"
    "agents/subagents/README.md"
    "skills/README.md"
    "skills/global-skills.md"
    "skills/frontend-skills.md"
    "skills/backend-skills.md"
    "skills/design-skills.md"
    "skills/database-skills.md"
    "skills/devops-skills.md"
    "skills/qa-skills.md"
    "skills/security-skills.md"
    "skills/documentation-skills.md"
    "templates/project-readme-template.md"
    "templates/env-template.env"
    "templates/agent-task-template.md"
    "templates/bug-report-template.md"
    "templates/implementation-plan-template.md"
    "templates/validation-report-template.md"
    "templates/documentation-template.md"
    "obsidian/second-brain-structure.md"
    "obsidian/project-knowledge-base-template.md"
    "obsidian/documentation-architecture.md"
    "obsidian/extracted-important-notes.md"
)

ERRORS=0

for rel_path in "${MANDATORY_FILES[@]}"; do
    full_path="$REPO_ROOT/$rel_path"
    if [ -f "$full_path" ]; then
        size=$(wc -c < "$full_path")
        if [ "$size" -gt 10 ]; then
            echo -e "\e[32m✅ [PRESENTE] $rel_path ($size bytes)\e[0m"
        else
            echo -e "\e[33m⚠️ [VAZIO] $rel_path está vazio.\e[0m"
            ERRORS=$((ERRORS + 1))
        fi
    else
        echo -e "\e[31m❌ [FALTANDO] $rel_path não existe!\e[0m"
        ERRORS=$((ERRORS + 1))
    fi
done

echo -e "\e[36m====================================================\e[0m"
if [ "$ERRORS" -eq 0 ]; then
    echo -e "\e[32m✅ Repositório 100% íntegro e validado com sucesso!\e[0m"
    exit 0
else
    echo -e "\e[31m❌ Validação do repositório falhou! Encontrados $ERRORS erros.\e[0m"
    exit 1
fi
