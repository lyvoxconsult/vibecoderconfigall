#!/usr/bin/env bash
set -Eeuo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$SCRIPT_DIR"
if [[ "$REPO_ROOT" == */scripts ]]; then
    REPO_ROOT="$(dirname "$REPO_ROOT")"
fi

echo "===================================================="
echo "Validando integridade do repositorio..."
echo "Diretorio base: $REPO_ROOT"
echo "===================================================="

MANDATORY_FILES=(
    "README.md"
    "QUICK_START.md"
    "SECURITY_NOTES.md"
    "CHANGELOG.md"
    ".gitignore"
    ".env.example"
    "agents/macbook-bootstrap-prompt.md"
    "agents/global-agent-rules.md"
    "agents/antigravity-global-prompt.md"
    "agents/codex-global-prompt.md"
    "agents/subagents/README.md"
    "configs/vscode/settings.json"
    "configs/antigravity/config.example.json"
    "configs/opencode/permissions.example.yaml"
    "mcp/mcp-config.example.json"
    "mcp/codex-mcp-config.example.toml"
    "docs/antigravity-setup.md"
    "docs/codex-setup.md"
    "docs/knowledge-governance.md"
    "docs/obsidian-structure.md"
    "docs/secrets-policy.md"
    "docs/SKILLS_INDEX.md"
    "skills obrigatorias/README.md"
    "skills obrigatorias/skills-manifest.json"
    "skills obrigatorias/mandatory-10-skills.md"
    "skills obrigatorias/global-skills.md"
    "skills obrigatorias/frontend-skills.md"
    "skills obrigatorias/backend-skills.md"
    "skills obrigatorias/design-skills.md"
    "skills obrigatorias/database-skills.md"
    "skills obrigatorias/devops-skills.md"
    "skills obrigatorias/qa-skills.md"
    "skills obrigatorias/security-skills.md"
    "skills obrigatorias/documentation-skills.md"
    "templates/project-readme-template.md"
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

errors=0

for rel_path in "${MANDATORY_FILES[@]}"; do
    full_path="$REPO_ROOT/$rel_path"
    if [[ -f "$full_path" ]]; then
        size=$(wc -c < "$full_path")
        if [[ "$size" -gt 10 ]]; then
            echo "[PRESENTE] $rel_path ($size bytes)"
        else
            echo "[VAZIO] $rel_path esta vazio ou com tamanho invalido."
            errors=$((errors + 1))
        fi
    else
        echo "[FALTANDO] $rel_path nao existe no repositorio."
        errors=$((errors + 1))
    fi
done

echo "===================================================="
if [[ "$errors" -eq 0 ]]; then
    echo "Repositorio validado com sucesso."
    exit 0
fi

echo "Validacao falhou. Erros estruturais: $errors"
exit 1
