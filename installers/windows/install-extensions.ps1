# ==============================================================================
# INSTALADOR DE EXTENSÕES VS CODE (Windows) - install-extensions.ps1
# ==============================================================================
# Instala em lote as extensões essenciais e recomendadas mapeadas do seu ambiente.
# ==============================================================================

Write-Host "🔍 Verificando presença da CLI do VS Code (code)..." -ForegroundColor Green
if (-not (Get-Command code -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️ Comando 'code' não encontrado! Garanta que o VS Code está instalado e adicionado ao seu PATH." -ForegroundColor Yellow
    exit 0
}

# Lista de extensões fundamentais e recomendadas mapeadas do seu ambiente original
$extensions = @(
    "anthropic.claude-code"
    "biomejs.biome"
    "christian-kohler.path-intellisense"
    "davidanson.vscode-markdownlint"
    "dbaeumer.vscode-eslint"
    "dracula-theme.theme-dracula"
    "dsznajder.es7-react-js-snippets"
    "eamodio.gitlens"
    "editorconfig.editorconfig"
    "esbenp.prettier-vscode"
    "fhgffy.antigravity-auto-accept"
    "ms-python.python"
    "ms-vscode-remote.remote-wsl"
    "ms-vscode.cpptools"
    "pkief.material-icon-theme"
    "streetsidesoftware.code-spell-checker"
    "usernamehw.errorlens"
)

Write-Host "🚀 Iniciando instalação em lote de $($extensions.Count) extensões..." -ForegroundColor Cyan

foreach ($ext in $extensions) {
    Write-Host "📦 Instalando/Atualizando extensão: $ext..." -ForegroundColor Yellow
    & code --install-extension $ext --force | Out-Null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ $ext instalada com sucesso!" -ForegroundColor LightGreen
    } else {
        Write-Host "⚠️ Falha ao instalar $ext." -ForegroundColor DarkYellow
    }
}

Write-Host "✅ Sincronização de extensões concluída!" -ForegroundColor Green
