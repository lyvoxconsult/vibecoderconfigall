# ==============================================================================
# CONFIGURADOR DE PYTHON E UV (Windows) - install-python.ps1
# ==============================================================================
# Garante a presença do Python e instala o gerenciador de pacotes ultraveloz uv.
# ==============================================================================

Write-Host "🔍 Verificando se o Python está instalado..." -ForegroundColor Green
# Evitar o atalho falso da Microsoft Store
$pythonTest = try { python --version 2>&1 } catch { $null }
$pythonInstalled = $false

if ($pythonTest -and $pythonTest -like "*Python 3*") {
    $pythonInstalled = $true
}

if (-not $pythonInstalled) {
    Write-Host "🚀 Python 3 não encontrado! Instalando Python via Winget..." -ForegroundColor Yellow
    winget install --id Python.Python.3.11 --silent --accept-source-agreements --accept-package-agreements
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Python instalado com sucesso! Reinicie o seu terminal." -ForegroundColor Green
    } else {
        Write-Host "⚠️ Falha ao instalar Python automaticamente via Winget." -ForegroundColor Yellow
    }
} else {
    Write-Host "✅ Python já presente no sistema ($pythonTest)." -ForegroundColor LightGreen
}

# Instalação do uv
Write-Host "🔍 Verificando se o gerenciador uv está instalado..." -ForegroundColor Green
if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
    Write-Host "🚀 uv não encontrado! Instalando o gerenciador de pacotes uv via script oficial..." -ForegroundColor Yellow
    try {
        powershell -ExecutionPolicy Bypass -Command "irm https://astral.sh/uv/install.ps1 | iex"
        Write-Host "✅ uv instalado com sucesso!" -ForegroundColor Green
    } catch {
        Write-Host "⚠️ Falha ao instalar uv. Você pode rodar 'pip install uv' de forma alternativa." -ForegroundColor Yellow
    }
} else {
    Write-Host "✅ uv já presente no sistema." -ForegroundColor LightGreen
}
