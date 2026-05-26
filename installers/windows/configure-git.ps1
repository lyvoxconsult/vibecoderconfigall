# ==============================================================================
# CONFIGURADOR GLOBAL DO GIT (Windows) - configure-git.ps1
# ==============================================================================
# Otimiza o comportamento global do Git e configura aliases úteis recomendados.
# ==============================================================================

Write-Host "🔍 Verificando presença do Git..." -ForegroundColor Green
if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Git não encontrado! Instale o Git antes de configurar." -ForegroundColor Red
    exit 1
}

Write-Host "🚀 Aplicando otimizações globais de comportamento do Git..." -ForegroundColor Yellow

# Otimizações recomendadas
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global core.autocrlf true
git config --global core.editor "code --wait"

# Aliases corporativos úteis
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.lg "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative"

Write-Host "✅ Aliases e comportamento globais do Git configurados!" -ForegroundColor Green
Write-Host "Nota: A identidade de usuário (user.name e user.email) deve ser configurada manualmente." -ForegroundColor Yellow
