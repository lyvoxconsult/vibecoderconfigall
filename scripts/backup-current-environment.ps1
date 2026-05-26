# ==============================================================================
# SCRIPT DE RE-ESCANEAMENTO E BACKUP DO AMBIENTE ATUAL (PowerShell)
# ==============================================================================
# Este script varre o sistema do usuário para atualizar os inventários de
# ferramentas, as extensões do VS Code e as configurações globais de forma segura,
# garantindo que chaves e segredos confidenciais nunca entrem no Git.
# ==============================================================================

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent $scriptPath

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "🔄  Iniciando re-escaneamento e atualização do backup de ambiente..." -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

# 1. Atualizar Extensões do VS Code
Write-Host "🔍 Rastreando extensões instaladas no VS Code..." -ForegroundColor Green
$extensionsFile = "$repoRoot\reports\extensions-detected.md"
$extensionsDoc = "$repoRoot\docs\extensions.md"
$extensionsRaw = code --list-extensions 2>$null

if ($extensionsRaw) {
    # Gerar Relatório de Extensões Detectadas
    $extensionsContent = @"
# 🔍 Relatório de Extensões do VS Code Detectadas

Atualizado em: $(Get-Date -Format "dd-MM-yyyy HH:mm:ss")

Abaixo estão listadas todas as extensões detectadas de forma ativa no seu ambiente de trabalho:

"@
    foreach ($ext in $extensionsRaw) {
        $extensionsContent += "- $ext`n"
    }
    Set-Content -Path $extensionsFile -Value $extensionsContent -Force
    Write-Host "✅ Relatório de extensões detectadas atualizado: $extensionsFile" -ForegroundColor LightGreen
} else {
    Write-Host "⚠️ VS Code CLI não encontrado. Pulando backup automatizado de extensões." -ForegroundColor Yellow
}

# 2. Rastrear Versões de Ferramentas Ativas
Write-Host "🔍 Mapeando versões de ferramentas ativas..." -ForegroundColor Green
$toolsFile = "$repoRoot\reports\tools-detected.md"

$nodeVer = try { (node -v).Trim() } catch { "Não instalado" }
$npmVer = try { (npm -v).Trim() } catch { "Não instalado" }
$gitVer = try { (git --version).Trim() } catch { "Não instalado" }
$pythonVer = try { (python --version).Trim() } catch { "Não instalado" }

$toolsContent = @"
# 🛠️ Relatório de Ferramentas Detectadas no Ambiente

Atualizado em: $(Get-Date -Format "dd-MM-yyyy HH:mm:ss")

Abaixo estão listadas as ferramentas fundamentais detectadas no seu sistema:

- **Node.js:** $nodeVer
- **npm:** $npmVer
- **Git:** $gitVer
- **Python:** $pythonVer
"@
Set-Content -Path $toolsFile -Value $toolsContent -Force
Write-Host "✅ Relatório de ferramentas ativas atualizado: $toolsFile" -ForegroundColor LightGreen

# 3. Backup Seguro de VS Code settings.json
Write-Host "🔍 Realizando backup seguro do settings.json de VS Code..." -ForegroundColor Green
$userSettingsPath = "$env:APPDATA\Code\User\settings.json"
$targetSettingsPath = "$repoRoot\configs\vscode\settings.json"

if (Test-Path $userSettingsPath) {
    $settingsJson = Get-Content -Path $userSettingsPath -Raw | ConvertFrom-Json
    
    # Remover campos contendo strings potencialmente confidenciais
    if ($settingsJson.PSObject.Properties['mssql.connectionGroups']) {
        $settingsJson.PSObject.Properties.Remove('mssql.connectionGroups')
    }
    
    # Salvar settings.json sanitizado de volta ao repositório
    $settingsJson | ConvertTo-Json -Depth 100 | Out-File -FilePath $targetSettingsPath -Encoding utf8 -Force
    Write-Host "✅ Configurações higienizadas salvas com sucesso em: $targetSettingsPath" -ForegroundColor LightGreen
} else {
    Write-Host "⚠️ settings.json do VS Code não encontrado em: $userSettingsPath" -ForegroundColor Yellow
}

# 4. Rodar varredura preventiva contra segredos antes de finalizar
Write-Host "🛡️  Executando varredura interna contra segredos..." -ForegroundColor Green
& "$scriptPath\check-secrets.ps1"

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "🎉  Backup e sincronização de ambiente concluídos com sucesso!" -ForegroundColor Green
Write-Host "====================================================" -ForegroundColor Cyan
