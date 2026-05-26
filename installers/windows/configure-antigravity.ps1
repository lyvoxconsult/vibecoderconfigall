# ==============================================================================
# CONFIGURADOR DE INTELIGÊNCIA DO ANTIGRAVITY (Windows) - configure-antigravity.ps1
# ==============================================================================
# Injeta os prompts globais higienizados na pasta local .gemini do usuário.
# ==============================================================================

$installerDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $installerDir

$antigravityConfigDir = "$env:USERPROFILE\.gemini\config"
$promptSource = "$repoRoot\agents\antigravity-global-prompt.md"

Write-Host "🚀 Configurando contexto e prompts globais do Antigravity..." -ForegroundColor Yellow

if (Test-Path $promptSource) {
    if (-not (Test-Path $antigravityConfigDir)) {
        New-Item -ItemType Directory -Force -Path $antigravityConfigDir | Out-Null
    }
    
    # Injetar o prompt global do Antigravity
    Copy-Item -Path $promptSource -Destination "$antigravityConfigDir\antigravity-global-prompt.md" -Force
    Write-Host "✅ Prompt global de sistema injetado com sucesso no Antigravity!" -ForegroundColor Green
} else {
    Write-Host "⚠️ Arquivo de prompt global não encontrado em: $promptSource" -ForegroundColor Yellow
}
