# ==============================================================================
# SCRIPT DE VALIDAÇÃO OPERACIONAL DO AMBIENTE (Windows) - validate.ps1
# ==============================================================================
# Testa se as dependências do ecossistema de desenvolvimento estão instaladas
# e respondendo nas versões adequadas no sistema Windows.
# ==============================================================================

$installerDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $installerDir

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "🔍  Validando Dependências e Conformidade do Ambiente..." -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

$validationErrors = 0

# 1. Validar Git
Write-Host "🔍 Testando Git..." -ForegroundColor Green
$gitVer = try { (git --version 2>&1).Trim() } catch { $null }
if ($gitVer) {
    Write-Host "✅ Git operando com sucesso: $gitVer" -ForegroundColor LightGreen
} else {
    Write-Host "❌ Git não respondendo no sistema!" -ForegroundColor Red
    $validationErrors++
}

# 2. Validar Node.js e npm
Write-Host "🔍 Testando Node.js..." -ForegroundColor Green
$nodeVer = try { (node -v 2>&1).Trim() } catch { $null }
if ($nodeVer) {
    Write-Host "✅ Node.js operando com sucesso: $nodeVer" -ForegroundColor LightGreen
} else {
    Write-Host "❌ Node.js não respondendo no sistema!" -ForegroundColor Red
    $validationErrors++
}

# 3. Validar pnpm
Write-Host "🔍 Testando pnpm..." -ForegroundColor Green
$pnpmVer = try { (pnpm -v 2>&1).Trim() } catch { $null }
if ($pnpmVer) {
    Write-Host "✅ pnpm operando com sucesso: v$pnpmVer" -ForegroundColor LightGreen
} else {
    Write-Host "⚠️ pnpm não respondendo. Lembrar de instalar globalmente via npm se necessário." -ForegroundColor Yellow
}

# 4. Validar Python
Write-Host "🔍 Testando Python..." -ForegroundColor Green
$pythonVer = try { (python --version 2>&1).Trim() } catch { $null }
if ($pythonVer -and $pythonVer -like "*Python 3*") {
    Write-Host "✅ Python operando com sucesso: $pythonVer" -ForegroundColor LightGreen
} else {
    Write-Host "⚠️ Python 3 não respondendo de forma ativa no console." -ForegroundColor Yellow
}

# 5. Validar configurações locais no VS Code
Write-Host "🔍 Verificando settings.json do VS Code..." -ForegroundColor Green
$settingsPath = "$env:APPDATA\Code\User\settings.json"
if (Test-Path $settingsPath) {
    Write-Host "✅ Arquivo settings.json do VS Code presente e operando." -ForegroundColor LightGreen
} else {
    Write-Host "❌ settings.json não encontrado nas pastas de usuário locais!" -ForegroundColor Red
    $validationErrors++
}

Write-Host "====================================================" -ForegroundColor Cyan
if ($validationErrors -eq 0) {
    Write-Host "✅ Parabéns! O seu ambiente Windows passou em todas as validações obrigatórias." -ForegroundColor Green
    exit 0
} else {
    Write-Host "❌ A validação do sistema encontrou $validationErrors problemas estruturais!" -ForegroundColor Red
    Write-Host "Consulte reports/pending-manual-actions.md para corrigir as dependências em falta." -ForegroundColor Red
    exit 1
}
