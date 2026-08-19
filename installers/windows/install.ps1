# ==============================================================================
# ORQUESTRADOR PRINCIPAL DE INSTALAÇÃO (Windows) - install.ps1
# ==============================================================================
# Este script gerencia e chama os instaladores específicos em sequência para
# configurar o seu ambiente de desenvolvimento de alta performance de forma
# automatizada, idempotente e segura.
# ==============================================================================

$installerDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $installerDir

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "🪐  Iniciando Provisionamento do Ambiente vibecoderconfigall..." -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

# 1. Verificar privilégios de execução
Write-Host "🔍 Verificando integridade operacional..." -ForegroundColor Green
$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "⚠️  Nota: Script executado sem privilégios de Administrador." -ForegroundColor Yellow
    Write-Host "Instalações globais via Winget podem exigir autenticação ou falhar se exigirem privilégios de sistema." -ForegroundColor Yellow
}

# 2. Executar instalador de Ferramentas / CLIs (Winget)
Write-Host "`n🚀 [Passo 1/7] Instalando CLIs e Utilitários de Desenvolvimento..." -ForegroundColor Cyan
& "$installerDir\install-tools.ps1"

# 3. Setup do Node.js
Write-Host "`n🚀 [Passo 2/7] Configurando ecossistema Node.js (LTS & pnpm)..." -ForegroundColor Cyan
& "$installerDir\install-node.ps1"

# 4. Setup do Python
Write-Host "`n🚀 [Passo 3/7] Configurando ecossistema Python (pip & uv)..." -ForegroundColor Cyan
& "$installerDir\install-python.ps1"

# 5. Instalar Extensões no VS Code
Write-Host "`n🚀 [Passo 4/7] Sincronizando extensões de IDE..." -ForegroundColor Cyan
& "$installerDir\install-extensions.ps1"

# 6. Configurar o Git Global
Write-Host "`n🚀 [Passo 5/7] Otimizando configurações globais do Git..." -ForegroundColor Cyan
& "$installerDir\configure-git.ps1"

# 7. Configurações de Agentes (Codex, Antigravity & OpenCode)
Write-Host "`n🚀 [Passo 6/8] Injetando regras de inteligência de Agentes..." -ForegroundColor Cyan
& "$installerDir\configure-codex.ps1"
& "$installerDir\configure-antigravity.ps1"

# 7b. Configurar skills do OpenCode
Write-Host "`n🚀 [Passo 7/8] Configurando ecossistema de skills do OpenCode..." -ForegroundColor Cyan
& "$installerDir\configure-opencode.ps1"

# 8. Validação Final do Ambiente
Write-Host "`n🚀 [Passo 8/8] Validando integridade operacional do sistema..." -ForegroundColor Cyan
& "$installerDir\validate.ps1"

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "🎉  Provisionamento concluído! Seu ambiente está pronto para uso." -ForegroundColor Green
Write-Host "Por favor, siga as etapas manuais indicadas no relatório." -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Cyan
