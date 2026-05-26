# ==============================================================================
# SCRIPT DE VALIDAÇÃO DE INTEGRIDADE DO REPOSITÓRIO (PowerShell) - validate-repo.ps1
# ==============================================================================
# Este script verifica se a estrutura de diretórios e os arquivos obrigatórios
# do repositório vibecoderconfigall estão presentes e íntegros.
# ==============================================================================

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
if ($repoRoot -like "*scripts*") {
    $repoRoot = Split-Path -Parent $repoRoot
}

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "🔍  Iniciando Validação de Integridade do Repositório..." -ForegroundColor Cyan
Write-Host "Diretório Base: $repoRoot" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

# Lista de arquivos cruciais obrigatórios
$mandatoryFiles = @(
    "README.md"
    "QUICK_START.md"
    "SECURITY_NOTES.md"
    "CHANGELOG.md"
    ".gitignore"
    ".env.example"
    "configs\vscode\settings.json"
    "configs\antigravity\config.example.json"
    "mcp\mcp-config.example.json"
    "mcp\codex-mcp-config.example.toml"
    "agents\global-agent-rules.md"
    "agents\antigravity-global-prompt.md"
    "agents\codex-global-prompt.md"
    "agents\subagents\README.md"
    "skills\README.md"
    "skills\global-skills.md"
    "skills\frontend-skills.md"
    "skills\backend-skills.md"
    "skills\design-skills.md"
    "skills\database-skills.md"
    "skills\devops-skills.md"
    "skills\qa-skills.md"
    "skills\security-skills.md"
    "skills\documentation-skills.md"
    "templates\project-readme-template.md"
    "templates\env-template.env"
    "templates\agent-task-template.md"
    "templates\bug-report-template.md"
    "templates\implementation-plan-template.md"
    "templates\validation-report-template.md"
    "templates\documentation-template.md"
    "obsidian\second-brain-structure.md"
    "obsidian\project-knowledge-base-template.md"
    "obsidian\documentation-architecture.md"
    "obsidian\extracted-important-notes.md"
)

$errorsCount = 0

foreach ($relPath in $mandatoryFiles) {
    $fullPath = Join-Path -Path $repoRoot -ChildPath $relPath
    if (Test-Path $fullPath) {
        $size = (Get-Item $fullPath).Length
        if ($size -gt 10) {
            Write-Host "✅ [PRESENTE] $relPath ($size bytes)" -ForegroundColor Green
        } else {
            Write-Host "⚠️ [VAZIO] $relPath está vazio ou com tamanho inválido." -ForegroundColor Yellow
            $errorsCount++
        }
    } else {
        Write-Host "❌ [FALTANDO] $relPath não existe no repositório!" -ForegroundColor Red
        $errorsCount++
    }
}

Write-Host "====================================================" -ForegroundColor Cyan
if ($errorsCount -eq 0) {
    Write-Host "✅ Repositório 100% íntegro e validado com sucesso!" -ForegroundColor Green
    exit 0
} else {
    Write-Host "❌ Validação do repositório falhou! Encontrados $errorsCount erros estruturais." -ForegroundColor Red
    exit 1
}
