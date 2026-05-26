# ==============================================================================
# CONFIGURADOR DE NODE.JS E PNPM (Windows) - install-node.ps1
# ==============================================================================
# Garante a presença do Node.js LTS e instala globalmente o gerenciador de
# pacotes pnpm. O script é idempotente.
# ==============================================================================

Write-Host "🔍 Verificando se o Node.js está instalado..." -ForegroundColor Green
if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
    Write-Host "🚀 Node.js não encontrado! Instalando Node.js LTS via Winget..." -ForegroundColor Yellow
    winget install --id OpenJS.NodeJS.LTS --silent --accept-source-agreements --accept-package-agreements
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Node.js LTS instalado com sucesso! Reinicie o terminal se necessário." -ForegroundColor Green
    } else {
        Write-Host "❌ Erro ao instalar o Node.js via Winget!" -ForegroundColor Red
        exit 1
    }
} else {
    $nodeVer = node -v
    Write-Host "✅ Node.js já presente no sistema (Versão: $nodeVer)." -ForegroundColor LightGreen
}

# Configurar pnpm globalmente
Write-Host "🔍 Verificando se o pnpm está instalado..." -ForegroundColor Green
if (-not (Get-Command pnpm -ErrorAction SilentlyContinue)) {
    Write-Host "🚀 pnpm não encontrado! Instalando pnpm globalmente via npm..." -ForegroundColor Yellow
    npm install -g pnpm
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ pnpm instalado globalmente com sucesso!" -ForegroundColor Green
    } else {
        Write-Host "⚠️ Falha ao instalar pnpm via npm. Tente instalar utilizando a instrução standalone do manual." -ForegroundColor Yellow
    }
} else {
    $pnpmVer = pnpm -v
    Write-Host "✅ pnpm já presente no sistema (Versão: $pnpmVer)." -ForegroundColor LightGreen
}
