# ==============================================================================
# SCRIPT DE RESTAURAÇÃO DE CONFIGURAÇÕES (PowerShell) - restore-windows.ps1
# ==============================================================================
# Este script restaura e injeta as configurações higienizadas do repositório
# para as pastas ativas de usuário locais do sistema operacional (ex: VS Code).
# ==============================================================================

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptPath

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "🔄  Iniciando restauração de configurações locais no Windows..." -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

# 1. Restaurar Configurações do VS Code
$userSettingsDir = "$env:APPDATA\Code\User"
$userSettingsPath = "$userSettingsDir\settings.json"
$repoSettingsPath = "$repoRoot\configs\vscode\settings.json"

if (Test-Path $repoSettingsPath) {
    if (-not (Test-Path $userSettingsDir)) {
        New-Item -ItemType Directory -Force -Path $userSettingsDir | Out-Null
    }
    
    # Backup da configuração local existente caso haja
    if (Test-Path $userSettingsPath) {
        $backupPath = "$userSettingsPath.bak"
        Copy-Item -Path $userSettingsPath -Destination $backupPath -Force
        Write-Host "💾 Backup do settings.json local atual realizado em: $backupPath" -ForegroundColor Yellow
    }
    
    # Copiar arquivo do repositório
    Copy-Item -Path $repoSettingsPath -Destination $userSettingsPath -Force
    Write-Host "✅ Configurações do VS Code injetadas com sucesso em: $userSettingsPath" -ForegroundColor Green
} else {
    Write-Host "❌ Erro: Configuração de settings.json não encontrada no repositório em: $repoSettingsPath" -ForegroundColor Red
}

# 2. Injetar Configurações do Antigravity
$antigravityDir = "$env:USERPROFILE\.gemini\config"
$repoAntigravityPath = "$repoRoot\configs\antigravity\config.example.json"
$targetAntigravityPath = "$antigravityDir\config.json"

if (Test-Path $repoAntigravityPath) {
    if (-not (Test-Path $antigravityDir)) {
        New-Item -ItemType Directory -Force -Path $antigravityDir | Out-Null
    }
    
    # Apenas copia caso o config.json físico local ainda não exista (preservar configurações ativas)
    if (-not (Test-Path $targetAntigravityPath)) {
        Copy-Item -Path $repoAntigravityPath -Destination $targetAntigravityPath -Force
        Write-Host "✅ Configurações de permissões do Antigravity criadas com sucesso em: $targetAntigravityPath" -ForegroundColor Green
    } else {
        Write-Host "ℹ️ Arquivo config.json do Antigravity já existe. Pulando cópia para evitar perda de dados ativos." -ForegroundColor Yellow
    }
}

# 3. Rodar validação
Write-Host "🔍 Executando validação de integridade pós-restauração..." -ForegroundColor Green
& "$repoRoot\installers\windows\validate.ps1"

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "🎉  Restauração e injeção de configurações concluídas com sucesso!" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Cyan
