# ==============================================================================
# SCRIPT DE AUDITORIA DE SEGREDOS (PowerShell) - check-secrets.ps1
# ==============================================================================
# Analisa recursivamente os arquivos em busca de chaves de API expostas,
# senhas em texto puro ou strings de conexao reais.
# ==============================================================================

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
if ($repoRoot -like "*scripts*") {
    $repoRoot = Split-Path -Parent $repoRoot
}

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "  Iniciando Auditoria Preventiva contra Vazamento de Segredos..." -ForegroundColor Cyan
Write-Host "  Diretorio Base: $repoRoot" -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

# Padroes Regex suspeitos de segredos e chaves de API
$secretPatterns = @{
    "GEMINI_API_KEY" = 'AIzaSy[A-Za-z0-9_\-]{35}'
    "OPENAI_API_KEY" = 'sk-[A-Za-z0-9_\-]{40,}'
    "ANTHROPIC_API_KEY" = 'sk-ant-[A-Za-z0-9_\-]{60,}'
    "GITHUB_TOKEN" = 'github_pat_[A-Za-z0-9_\-]{60,}'
    "VERCEL_TOKEN" = 'vercel_token_[A-Za-z0-9_\-]{20,}'
    "Supabase_JWT" = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9\.[A-Za-z0-9_=\-]{30,}\.[A-Za-z0-9_=\-]{40,}'
    "Chave_Privada" = '-----BEGIN [A-Z ]+ PRIVATE KEY-----'
}

$secretsFoundCount = 0

# Buscar arquivos ignorando node_modules, .git, etc.
$filesToScan = Get-ChildItem -Path $repoRoot -Recurse -File | Where-Object {
    $_.FullName -notlike "*node_modules*" -and
    $_.FullName -notlike "*.git*" -and
    $_.FullName -notlike "*check-secrets*" -and
    $_.FullName -notlike "*.env.example" -and
    $_.FullName -notlike "*SECURITY_NOTES.md"
}

foreach ($file in $filesToScan) {
    try {
        $content = Get-Content -Path $file.FullName -Raw -ErrorAction SilentlyContinue
    } catch {
        continue
    }
    if ([string]::IsNullOrEmpty($content)) { continue }

    foreach ($patternName in $secretPatterns.Keys) {
        $pattern = $secretPatterns[$patternName]
        if ($content -match $pattern) {
            Write-Host "  ALERTA: Assinatura suspeita [$patternName] detectada!" -ForegroundColor Yellow
            Write-Host ("  Arquivo: " + $file.FullName) -ForegroundColor Red
            $secretsFoundCount++
        }
    }
}

Write-Host "====================================================" -ForegroundColor Cyan
if ($secretsFoundCount -eq 0) {
    Write-Host "  Auditoria concluida! Nenhum segredo exposto detectado." -ForegroundColor Green
    exit 0
} else {
    Write-Host "  Falha! Encontradas $secretsFoundCount ocorrencias de segredos." -ForegroundColor Red
    Write-Host "  Remova as credenciais reais antes de commitar." -ForegroundColor Red
    exit 1
}
