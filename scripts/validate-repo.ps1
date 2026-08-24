# ==============================================================================
# SCRIPT DE VALIDACAO DE INTEGRIDADE DO REPOSITORIO (PowerShell)
# ==============================================================================

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
if ($repoRoot -like "*scripts*") {
    $repoRoot = Split-Path -Parent $repoRoot
}

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "Validando integridade do repositorio..." -ForegroundColor Cyan
Write-Host "Diretorio base: $repoRoot" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

$mandatoryFiles = @(
    "README.md",
    "QUICK_START.md",
    "SECURITY_NOTES.md",
    "CHANGELOG.md",
    ".gitignore",
    ".env.example",
    "agents\macbook-bootstrap-prompt.md",
    "agents\global-agent-rules.md",
    "agents\antigravity-global-prompt.md",
    "agents\codex-global-prompt.md",
    "agents\subagents\README.md",
    "configs\vscode\settings.json",
    "configs\antigravity\config.example.json",
    "configs\opencode\permissions.example.yaml",
    "mcp\mcp-config.example.json",
    "mcp\codex-mcp-config.example.toml",
    "docs\antigravity-setup.md",
    "docs\codex-setup.md",
    "docs\knowledge-governance.md",
    "docs\obsidian-structure.md",
    "docs\secrets-policy.md",
    "docs\SKILLS_INDEX.md",
    "skills obrigatorias\README.md",
    "skills obrigatorias\skills-manifest.json",
    "skills obrigatorias\mandatory-10-skills.md",
    "skills obrigatorias\global-skills.md",
    "skills obrigatorias\frontend-skills.md",
    "skills obrigatorias\backend-skills.md",
    "skills obrigatorias\design-skills.md",
    "skills obrigatorias\database-skills.md",
    "skills obrigatorias\devops-skills.md",
    "skills obrigatorias\qa-skills.md",
    "skills obrigatorias\security-skills.md",
    "skills obrigatorias\documentation-skills.md",
    "templates\project-readme-template.md",
    "templates\agent-task-template.md",
    "templates\bug-report-template.md",
    "templates\implementation-plan-template.md",
    "templates\validation-report-template.md",
    "templates\documentation-template.md",
    "obsidian\second-brain-structure.md",
    "obsidian\project-knowledge-base-template.md",
    "obsidian\documentation-architecture.md",
    "obsidian\extracted-important-notes.md"
)

$errorsCount = 0

foreach ($relPath in $mandatoryFiles) {
    $fullPath = Join-Path -Path $repoRoot -ChildPath $relPath
    if (Test-Path -LiteralPath $fullPath -PathType Leaf) {
        $size = (Get-Item -LiteralPath $fullPath).Length
        if ($size -gt 10) {
            Write-Host "[PRESENTE] $relPath ($size bytes)" -ForegroundColor Green
        } else {
            Write-Host "[VAZIO] $relPath esta vazio ou com tamanho invalido." -ForegroundColor Yellow
            $errorsCount++
        }
    } else {
        Write-Host "[FALTANDO] $relPath nao existe no repositorio." -ForegroundColor Red
        $errorsCount++
    }
}

Write-Host "====================================================" -ForegroundColor Cyan
if ($errorsCount -eq 0) {
    Write-Host "Repositorio validado com sucesso." -ForegroundColor Green
    exit 0
}

Write-Host "Validacao falhou. Erros estruturais: $errorsCount" -ForegroundColor Red
exit 1
