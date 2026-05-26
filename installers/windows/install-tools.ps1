# ==============================================================================
# INSTALADOR DE FERRAMENTAS E CLIS (Windows) - install-tools.ps1
# ==============================================================================
# Instala CLIs utilitárias e softwares essenciais usando o Winget.
# O script é totalmente idempotente e ignora ferramentas já instaladas.
# ==============================================================================

Write-Host "🔍 Rastreando instalador do Winget..." -ForegroundColor Green
if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Winget não encontrado no PATH! Instale o Gerenciador de Pacotes do Windows manualmente." -ForegroundColor Red
    exit 1
}

# Dicionário de softwares recomendados no Winget
$wingetPackages = @{
    "Git" = "Git.Git"
    "GitHub CLI" = "GitHub.cli"
    "VS Code" = "Microsoft.VisualStudioCode"
    "Docker Desktop" = "Docker.DockerDesktop"
}

foreach ($pkgName in $wingetPackages.Keys) {
    $pkgId = $wingetPackages[$pkgName]
    Write-Host "🔍 Verificando se $pkgName está instalado..." -ForegroundColor Green
    
    # Detecção simples de ferramenta
    $alreadyInstalled = $false
    if ($pkgName -eq "Git" -and (Get-Command git -ErrorAction SilentlyContinue)) { $alreadyInstalled = $true }
    if ($pkgName -eq "GitHub CLI" -and (Get-Command gh -ErrorAction SilentlyContinue)) { $alreadyInstalled = $true }
    if ($pkgName -eq "VS Code" -and (Get-Command code -ErrorAction SilentlyContinue)) { $alreadyInstalled = $true }
    if ($pkgName -eq "Docker Desktop" -and (Get-Command docker -ErrorAction SilentlyContinue)) { $alreadyInstalled = $true }
    
    if ($alreadyInstalled) {
        Write-Host "✅ $pkgName já está presente no sistema. Pulando instalação." -ForegroundColor LightGreen
    } else {
        Write-Host "🚀 Instalando $pkgName via Winget (ID: $pkgId)..." -ForegroundColor Yellow
        winget install --id $pkgId --silent --accept-source-agreements --accept-package-agreements
        if ($LASTEXITCODE -eq 0) {
            Write-Host "✅ $pkgName instalado com sucesso!" -ForegroundColor Green
        } else {
            Write-Host "⚠️ Falha ao instalar $pkgName automaticamente via Winget. Prossiga de forma manual." -ForegroundColor Yellow
        }
    }
}
