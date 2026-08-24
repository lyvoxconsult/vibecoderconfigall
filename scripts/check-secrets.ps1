param(
    [string]$Path
)

$repoRoot = if ($Path) { (Resolve-Path -LiteralPath $Path).Path } else { Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path) }
$patterns = [ordered]@{
    PRIVATE_KEY = '-----BEGIN (?:RSA |EC |OPENSSH |DSA )?PRIVATE KEY-----'
    AWS_KEY = '(?<![A-Z0-9])AKIA[0-9A-Z]{16}(?![A-Z0-9])'
    GITHUB_TOKEN = '(?<![A-Za-z0-9_])(?:gh[pousr]_[A-Za-z0-9_]{30,}|github_pat_[A-Za-z0-9_]{50,})(?![A-Za-z0-9_])'
    OPENAI_KEY = '(?<![A-Za-z0-9_-])sk-(?:proj-)?[A-Za-z0-9_-]{20,}(?![A-Za-z0-9_-])'
    SLACK_TOKEN = '(?<![A-Za-z0-9-])xox[baprs]-[A-Za-z0-9-]{20,}(?![A-Za-z0-9-])'
    TELEGRAM_TOKEN = '(?<![0-9])[0-9]{8,10}:[A-Za-z0-9_-]{35}(?![A-Za-z0-9_-])'
    JWT = '(?<![A-Za-z0-9_-])eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}(?![A-Za-z0-9_-])'
    DATABASE_URL = '(?:postgres(?:ql)?|mongodb(?:\+srv)?)://[^\s:]+:[^\s@]+@'
    ASSIGNED_SECRET = '(?im)(?:password|passwd|secret|token|api[_-]?key|connection[_-]?string)\s*[:=]\s*[^\s<>{}]{12,}'
}
$forbiddenNames = @('.env','id_rsa','id_ed25519')
$findings = 0
$files = Get-ChildItem -LiteralPath $repoRoot -Recurse -File -ErrorAction SilentlyContinue | Where-Object {
    $relative = $_.FullName.Substring($repoRoot.Length).TrimStart('\')
    $excluded = $relative -like '.git\*' -or $relative -like 'node_modules\*' -or $relative -like 'dist\*' -or $relative -like 'build\*' -or $relative -like 'graphify-out\*' -or $relative -eq 'scripts\check-secrets.ps1'
    -not $excluded
}
foreach ($file in $files) {
    $relative = $file.FullName.Substring($repoRoot.Length).TrimStart('\')
    $isExample = $file.Name -eq '.env.example' -or $file.Name -like '*.env.example'
    if (-not $isExample -and ($forbiddenNames -contains $file.Name -or $file.Extension -in @('.pem','.key','.p12','.pfx','.sqlite','.sqlite3','.db'))) {
        Write-Error "Arquivo sensível proibido: $relative"; $findings++
    }
    $content = Get-Content -LiteralPath $file.FullName -Raw -ErrorAction SilentlyContinue
    if ([string]::IsNullOrEmpty($content)) { continue }
    foreach ($entry in $patterns.GetEnumerator()) {
        $matches = [regex]::Matches($content, $entry.Value)
        foreach ($match in $matches) {
            if ($entry.Key -eq 'ASSIGNED_SECRET' -and $match.Value -match '(?i)CHANGE_ME|SUBSTITUA|COLOQUE_|PLACEHOLDER|EXAMPLE|SEU_|SUA_') { continue }
            $line = 1 + ([regex]::Matches($content.Substring(0, $match.Index), "`n")).Count
            Write-Error "$($entry.Key): $relative linha $line"; $findings++
        }
    }
}
if ($findings -gt 0) { Write-Error "Security scan falhou: $findings achado(s)."; exit 1 }
Write-Host 'PASS: nenhuma assinatura de alta confiança ou arquivo proibido encontrado.'
exit 0
