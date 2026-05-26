# ==============================================================================
# CONFIGURADOR DE INTELIGÊNCIA DO CODEX (Windows) - configure-codex.ps1
# ==============================================================================
# Cria a estrutura de pastas do Codex local e injeta os prompts globais higienizados.
# ==============================================================================

$installerDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $installerDir

# Supondo diretório padrão de configurações locais do Codex no usuário
$codexLocalDir = "$env:USERPROFILE\.codex"
$promptSource = "$repoRoot\agents\codex-global-prompt.md"

Write-Host "🚀 Configurando contexto e prompts globais do Codex..." -ForegroundColor Yellow

if (Test-Path $promptSource) {
    if (-not (Test-Path $codexLocalDir)) {
        New-Item -ItemType Directory -Force -Path $codexLocalDir | Out-Null
    }
    
    # Injetar o prompt do Codex no diretório padrão do usuário
    Copy-Item -Path $promptSource -Destination "$codexLocalDir\codex-global-prompt.md" -Force
    Write-Host "✅ Prompt global de sistema injetado com sucesso no Codex!" -ForegroundColor Green
} else {
    Write-Host "⚠️ Arquivo de prompt global não encontrado em: $promptSource" -ForegroundColor Yellow
}
