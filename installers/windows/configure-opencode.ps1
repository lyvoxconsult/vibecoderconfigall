# ==============================================================================
# CONFIGURADOR DE SKILLS DO OPENCODE (Windows) - configure-opencode.ps1
# ==============================================================================
# Escaneia, deduplica, consolida e registra todas as skills do ecossistema
# para uso com o OpenCode (agente de IA de codificação).
#
# Integra:
#   - .agents/skills/          (skills do ecossistema OpenCode)
#   - vibecoderconfigall/skills/ (skills curadas do usuário)
#   - vibecoderconfigall/skills-pack/ (backup de skills Antigravity + Codex)
# ==============================================================================

param(
    [switch]$DryRun,
    [switch]$Force
)

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = Split-Path -Parent (Split-Path -Parent $scriptPath)
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

# ==============================================================================
# PATHS PRINCIPAIS
# ==============================================================================
$agentsSkillsDir = "$env:USERPROFILE\.agents\skills"
$claudeSkillsDir = "$env:USERPROFILE\.claude\skills"
$rootClaudeSkillsDir = "C:\.claude\skills"
$repoSkillsDir = "$repoRoot\skills"
$repoPackAntigravityDir = "$repoRoot\skills-pack\antigravity"
$repoPackCodexDir = "$repoRoot\skills-pack\codex"
$repoAgentsDir = "$repoRoot\agents"
$globalClaudeMdPath = "$env:USERPROFILE\.claude\CLAUDE.md"
$opencodeConfigPath = "$env:USERPROFILE\.config\opencode\opencode.json"
$skillsIndexPath = "$repoRoot\docs\SKILLS_INDEX.md"
$globalAgentRulesPath = "$repoRoot\agents\global-agent-rules.md"

# ==============================================================================
# SKILLS JÁ REGISTRADAS NO OPENCODE (available_skills)
# ==============================================================================
$registeredSkillNames = @(
    "defuddle",
    "devpromptarchitect",
    "json-canvas",
    "multiagent-qa-orchestration",
    "obsidian-bases",
    "obsidian-cli",
    "obsidian-markdown",
    "rbac-access-control-architect",
    "supabase",
    "supabase-postgres-best-practices"
)

$registeredDescriptions = @{
    "defuddle"                       = "Extração de markdown limpo de páginas web"
    "devpromptarchitect"             = "Arquitetura e planejamento de prompts"
    "json-canvas"                    = "Criação e edição de JSON Canvas (.canvas)"
    "multiagent-qa-orchestration"    = "Orquestração de múltiplos agentes com QA"
    "obsidian-bases"                 = "Criação de Bases (.base) no Obsidian"
    "obsidian-cli"                   = "Interação com vault Obsidian via CLI"
    "obsidian-markdown"              = "Markdown com sintaxe Obsidian"
    "rbac-access-control-architect"  = "Controle de acesso por função (RBAC)"
    "supabase"                       = "Tudo sobre Supabase (Auth, DB, Storage, Functions)"
    "supabase-postgres-best-practices" = "Otimização de PostgreSQL"
}

# ==============================================================================
# FUNÇÕES AUXILIARES
# ==============================================================================

function Write-Banner {
    param([string]$Message, [string]$Color = "Cyan")
    Write-Host "`n====================================================" -ForegroundColor $Color
    Write-Host " $Message" -ForegroundColor $Color
    Write-Host "====================================================" -ForegroundColor $Color
}

function Write-Step {
    param([string]$Message)
    Write-Host "  $Message" -ForegroundColor Yellow
}

function Write-Success {
    param([string]$Message)
    Write-Host "    [$([char]0x2705)] $Message" -ForegroundColor Green
}

function Write-Skip {
    param([string]$Message)
    Write-Host "    [$([char]0x23ED)] $Message" -ForegroundColor DarkGray
}

function Write-Warn {
    param([string]$Message)
    Write-Host "    [$([char]0x26A0)] $Message" -ForegroundColor Yellow
}

function Get-SkillsFromDirectory {
    param([string]$Directory, [string]$Source)
    
    $results = @()
    if (-not (Test-Path $Directory)) { return $results }
    
    # Procura por SKILL.md em subdiretórios
    $items = Get-ChildItem -Path $Directory -Directory -ErrorAction SilentlyContinue
    foreach ($item in $items) {
        $skillMd = Join-Path $item.FullName "SKILL.md"
        
        if (Test-Path $skillMd) {
            $results += [PSCustomObject]@{
                Name        = $item.Name.ToLower()
                Source      = $Source
                Path        = $item.FullName
                SkillMdPath = $skillMd
                Type        = "SKILL.md directory"
            }
        }
    }
    
    # Procura por arquivos *-skills.md na raiz (formato vibecoderconfigall)
    if (Test-Path $Directory) {
        $mdFiles = Get-ChildItem -Path $Directory -Filter "*-skills.md" -ErrorAction SilentlyContinue
        foreach ($mdFile in $mdFiles) {
            $skillName = $mdFile.BaseName.ToLower()
            $results += [PSCustomObject]@{
                Name        = $skillName
                Source      = $Source
                Path        = $mdFile.DirectoryName
                SkillMdPath = $mdFile.FullName
                Type        = "Flat .md file"
            }
        }
    }
    
    return $results
}

# ==============================================================================
# PHASE 1: SCAN & INVENTORY
# ==============================================================================
Write-Banner "FASE 1: Escaneando todas as fontes de skills"

$allSkills = @()

# 1.1 Skills do .agents/skills/
Write-Step "Varrendo .agents/skills/..."
$allSkills += Get-SkillsFromDirectory -Directory $agentsSkillsDir -Source ".agents/skills"

# 1.2 Skills curadas do vibecoderconfigall/skills/
Write-Step "Varrendo vibecoderconfigall/skills/ (skills curadas)..."
$allSkills += Get-SkillsFromDirectory -Directory $repoSkillsDir -Source "vibecoderconfigall/skills"

# 1.3 Skills do skills-pack/antigravity/
$antigravityCount = (Get-ChildItem $repoPackAntigravityDir -Directory -ErrorAction SilentlyContinue | Measure-Object).Count
Write-Step "Varrendo skills-pack/antigravity/ ($antigravityCount skills)..."
$allSkills += Get-SkillsFromDirectory -Directory $repoPackAntigravityDir -Source "skills-pack/antigravity"

# 1.4 Skills do skills-pack/codex/
$codexCount = (Get-ChildItem $repoPackCodexDir -Directory -ErrorAction SilentlyContinue | Measure-Object).Count
Write-Step "Varrendo skills-pack/codex/ ($codexCount skills)..."
$allSkills += Get-SkillsFromDirectory -Directory $repoPackCodexDir -Source "skills-pack/codex"

# 1.5 Verificar duplicatas no .claude/skills/
Write-Step "Varrendo .claude/skills/ (verificando duplicatas)..."
$allSkills += Get-SkillsFromDirectory -Directory $claudeSkillsDir -Source ".claude/skills"

Write-Host "`nTotal de skills encontradas: $($allSkills.Count)" -ForegroundColor Green

# ==============================================================================
# PHASE 2: DEDUPLICATION
# ==============================================================================
Write-Banner "FASE 2: Deduplicando skills"

$uniqueSkills = @{}
$duplicatesRemoved = 0
$priorityOrder = @(
    ".agents/skills",
    "vibecoderconfigall/skills",
    ".claude/skills",
    "skills-pack/antigravity",
    "skills-pack/codex"
)

foreach ($skill in $allSkills) {
    $name = $skill.Name
    if ($uniqueSkills.ContainsKey($name)) {
        $existing = $uniqueSkills[$name]
        $existingPriority = [array]::IndexOf($priorityOrder, $existing.Source)
        $newPriority = [array]::IndexOf($priorityOrder, $skill.Source)
        
        if ($newPriority -ge 0 -and ($existingPriority -eq -1 -or $newPriority -lt $existingPriority)) {
            $duplicatesRemoved++
            Write-Skip "Duplicata '$name' ($($existing.Source) -> $($skill.Source)): mantendo $($skill.Source)"
            $uniqueSkills[$name] = $skill
        } else {
            $duplicatesRemoved++
            Write-Skip "Duplicata '$name' ($($existing.Source) -> $($skill.Source)): mantendo $($existing.Source)"
        }
    } else {
        $uniqueSkills[$name] = $skill
    }
}

Write-Host "`nSkills unicas apos deduplicacao: $($uniqueSkills.Count)" -ForegroundColor Green
Write-Host "Duplicatas removidas: $duplicatesRemoved" -ForegroundColor Yellow

# ==============================================================================
# PHASE 3: CROSS-REFERENCE WITH REGISTERED SKILLS
# ==============================================================================
Write-Banner "FASE 3: Cross-reference com skills registradas no OpenCode"

$newSkills = @()
$alreadyRegistered = @()

foreach ($kvp in $uniqueSkills.GetEnumerator()) {
    if ($kvp.Key -in $registeredSkillNames) {
        $alreadyRegistered += $kvp.Value
    } else {
        $newSkills += $kvp.Value
    }
}

Write-Host "Skills ja registradas no OpenCode: $($alreadyRegistered.Count)" -ForegroundColor Green
foreach ($s in ($alreadyRegistered | Sort-Object Name)) {
    Write-Skip "$($s.Name) ($($s.Source))"
}

Write-Host "`nSkills NOVAS (nao registradas): $($newSkills.Count)" -ForegroundColor Cyan
foreach ($s in ($newSkills | Sort-Object Name)) {
    Write-Host "    $($s.Name) - $($s.Source) [$($s.Type)]" -ForegroundColor White
}

# ==============================================================================
# PHASE 4: CONSOLIDATE SKILLS
# ==============================================================================
Write-Banner "FASE 4: Consolidando skills no .agents/skills/"

$linkedCount = 0
$skippedCount = 0

foreach ($skill in $newSkills) {
    $targetDir = Join-Path $agentsSkillsDir $skill.Name
    
    # Se a skill ja esta em .agents/skills/, so verificar
    if ($skill.Source -eq ".agents/skills") {
        if (Test-Path $targetDir) {
            Write-Skip "$($skill.Name) ja esta em .agents/skills/"
            $skippedCount++
            continue
        }
    }
    
    # Skills curadas do vibecoderconfigall: copiar como SKILL.md
    if ($skill.Source -eq "vibecoderconfigall/skills" -and $skill.Type -eq "Flat .md file") {
        if ($DryRun) {
            Write-Host "    [DryRun] Criaria: $targetDir com SKILL.md <- $($skill.SkillMdPath)"
            continue
        }
        
        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Force -Path $targetDir | Out-Null
        }
        
        Copy-Item -Path $skill.SkillMdPath -Destination (Join-Path $targetDir "SKILL.md") -Force
        Write-Success "$($skill.Name) copiado para .agents/skills/"
        $linkedCount++
        continue
    }
    
    # Skills do skills-pack: apenas referenciar (nao copiar)
    if ($skill.Source -like "skills-pack/*") {
        Write-Skip "$($skill.Name) (skills-pack: referenciado via SKILLS_INDEX.md)"
        $skippedCount++
        continue
    }
}

if (-not $DryRun) {
    Write-Success "Skills consolidadas: $linkedCount copiadas, $skippedCount referenciadas"
}

# ==============================================================================
# PHASE 5: GENERATE SKILLS INDEX
# ==============================================================================
Write-Banner "FASE 5: Gerando SKILLS_INDEX.md"

$agentsNewForIndex = $newSkills | Where-Object { $_.Source -eq ".agents/skills" } | Sort-Object Name
$repoNewForIndex = $newSkills | Where-Object { $_.Source -eq "vibecoderconfigall/skills" } | Sort-Object Name
$antigravityNewForIndex = $newSkills | Where-Object { $_.Source -eq "skills-pack/antigravity" }
$codexNewForIndex = $newSkills | Where-Object { $_.Source -eq "skills-pack/codex" }

$indexLines = @()
$indexLines += "# SKILLS INDEX -- OpenCode Ecosystem"
$indexLines += "> Gerado em: $timestamp"
$indexLines += "> Proposito: Indice centralizado de todas as skills disponiveis no ecossistema"
$indexLines += ""
$indexLines += "## Skills Registradas no OpenCode ($($alreadyRegistered.Count))"
$indexLines += "Skills que ja estao registradas como available_skills e podem ser carregadas com skill load:"
$indexLines += ""
$indexLines += "| Skill | Fonte |"
$indexLines += "|---|---|"

foreach ($s in ($alreadyRegistered | Sort-Object Name)) {
    $indexLines += "| **$($s.Name)** | $($s.Source) |"
}

$indexLines += ""
$indexLines += "## Skills Novas em .agents/skills/ ($($agentsNewForIndex.Count))"
$indexLines += "Skills que estao no diretorio .agents/skills/ mas nao estao registradas como available_skills."
$indexLines += ""
$indexLines += "| Skill | Path |"
$indexLines += "|---|---|"

foreach ($s in $agentsNewForIndex) {
    $indexLines += "| $($s.Name) | .agents/skills/$($s.Name)/ |"
}

$indexLines += ""
$indexLines += "## Skills Curadas do vibecoderconfigall ($($repoNewForIndex.Count))"
$indexLines += "Skills autorais do usuario:"
$indexLines += ""
$indexLines += "| Skill | Path Original |"
$indexLines += "|---|---|"

foreach ($s in $repoNewForIndex) {
    $origName = $s.Name -replace '-skills', ''
    $indexLines += "| $($s.Name) | vibecoderconfigall/skills/$origName.md |"
}

$indexLines += ""
$indexLines += "## Skills Pack -- Antigravity ($($antigravityNewForIndex.Count))"
$indexLines += "Backup completo de skills do Antigravity IDE."
$indexLines += "Path: vibecoderconfigall/skills-pack/antigravity/"
$indexLines += ""
$indexLines += 'Para restaurar no Antigravity:'
$indexLines += '```powershell'
$indexLines += "robocopy `"$repoPackAntigravityDir`" `"`$env:USERPROFILE\.gemini\config\skills`" /E"
$indexLines += '```'
$indexLines += ""
$indexLines += "## Skills Pack -- Codex ($($codexNewForIndex.Count))"
$indexLines += "Backup completo de skills do Codex CLI."
$indexLines += "Path: vibecoderconfigall/skills-pack/codex/"
$indexLines += ""
$indexLines += 'Para restaurar no Codex:'
$indexLines += '```powershell'
$indexLines += "robocopy `"$repoPackCodexDir`" `"`$env:USERPROFILE\.codex\skills`" /E"
$indexLines += '```'

$indexContent = $indexLines -join "`n"

if (-not $DryRun) {
    $docsDir = Split-Path $skillsIndexPath -Parent
    if (-not (Test-Path $docsDir)) {
        New-Item -ItemType Directory -Force -Path $docsDir | Out-Null
    }
    Set-Content -Path $skillsIndexPath -Value $indexContent -Encoding UTF8
    Write-Success "SKILLS_INDEX.md gerado em: $skillsIndexPath"
}

# ==============================================================================
# PHASE 6: GENERATE GLOBAL CLAUDE.md
# ==============================================================================
Write-Banner "FASE 6: Gerando CLAUDE.md global com regras de auto-escaneamento"

$claudeLines = @()
$claudeLines += "# CLAUDE.md -- Configuracao Global do OpenCode"
$claudeLines += "> Gerado automaticamente por vibecoderconfigall em $timestamp"
$claudeLines += ""
$claudeLines += "## Skills Disponiveis"
$claudeLines += ""
$claudeLines += "### Skills Registradas (carregaveis via skill load)"
$claudeLines += "| Skill | Descricao |"
$claudeLines += "|---|---|"

$sortedNames = $registeredDescriptions.Keys | Sort-Object
foreach ($name in $sortedNames) {
    $desc = $registeredDescriptions[$name]
    $claudeLines += "| $name | $desc |"
}

$claudeLines += ""
$claudeLines += "### Skills em .agents/skills/ ($($agentsNewForIndex.Count))"

if ($agentsNewForIndex.Count -gt 0) {
    $claudeLines += ""
    $items = @()
    foreach ($s in $agentsNewForIndex) {
        $items += "- $($s.Name)"
    }
    $claudeLines += $items -join "`n"
}

$claudeLines += ""
$claudeLines += "### Skills Curadas do Usuario ($($repoNewForIndex.Count))"

if ($repoNewForIndex.Count -gt 0) {
    $claudeLines += ""
    $items = @()
    foreach ($s in $repoNewForIndex) {
        $items += "- $($s.Name)"
    }
    $claudeLines += $items -join "`n"
}

$claudeLines += ""
$claudeLines += "## Skills Pack ($($antigravityNewForIndex.Count + $codexNewForIndex.Count) skills)"
$claudeLines += "- Antigravity ($($antigravityNewForIndex.Count) skills): vibecoderconfigall/skills-pack/antigravity/"
$claudeLines += "- Codex ($($codexNewForIndex.Count) skills): vibecoderconfigall/skills-pack/codex/"
$claudeLines += ""
$claudeLines += "Para inventario completo, consulte docs/SKILLS_INDEX.md no projeto vibecoderconfigall."
$claudeLines += ""
$claudeLines += "## Regras de Operacao com Skills"
$claudeLines += ""
$claudeLines += "### Auto-escaneamento OBRIGATORIO de Skills"
$claudeLines += "Ao receber QUALQUER tarefa tecnica, siga este fluxo:"
$claudeLines += ""
$claudeLines += "1. **Classifique o dominio** da tarefa (backend, frontend, database, devops, security, design, architecture, testing, IA, obsidian, supabase, etc.)"
$claudeLines += ""
$claudeLines += "2. **Escaneie proativamente** os diretorios de skills para encontrar SKILL.md relevante:"
$claudeLines += "   - `.agents/skills/` (habilitei estas skills diretamente, prioridade alta)"
$claudeLines += "   - skills-pack/antigravity (skills especializadas por dominio)"
$claudeLines += "   - skills-pack/codex (skills especializadas por ferramenta/biblioteca)"
$claudeLines += ""
$claudeLines += "3. **Use ferramentas de busca** para localizar skills rapidamente:"
$claudeLines += "   - `glob **/SKILL.md` para listar skills disponiveis"
$claudeLines += "   - `grep` pelo nome/descricao do dominio nos SKILL.md encontrados"
$claudeLines += ""
$claudeLines += "4. **Leia e aplique** o SKILL.md das skills mais relevantes antes de executar"
$claudeLines += ""
$claudeLines += "5. **Skills registradas** (skill load) tem prioridade maxima"
$claudeLines += ""
$claudeLines += "6. **Sem skill correspondente**: Use conhecimento geral seguindo melhores praticas"
$claudeLines += ""
$claudeLines += "### Ordem de busca de skills"
$claudeLines += "1. `.agents/skills/` (mais especificas do ecossistema)"
$claudeLines += "2. `skills-pack/antigravity/` (larga cobertura de dominios)"
$claudeLines += "3. `skills-pack/codex/` (especificas por ferramenta/plataforma)"
$claudeLines += "4. `.claude/skills/` (legado)"
$claudeLines += "5. Conhecimento geral do modelo"
$claudeLines += ""
$claudeLines += "---"
$claudeLines += "*Mantido por vibecoderconfigall -- ecossistema de configuracao de ambiente de alta performance*"

$claudeContent = $claudeLines -join "`n"

if (-not $DryRun) {
    Set-Content -Path $globalClaudeMdPath -Value $claudeContent -Encoding UTF8
    Write-Success "CLAUDE.md global atualizado em: $globalClaudeMdPath"
}

# ==============================================================================
# PHASE 7: UPDATE GLOBAL AGENT RULES
# ==============================================================================
Write-Banner "FASE 7: Atualizando regras globais dos agentes"

$rulesAppendLines = @()
$rulesAppendLines += ""
$rulesAppendLines += "---"
$rulesAppendLines += ""
$rulesAppendLines += "## 5. Ecossistema de Skills OpenCode"
$rulesAppendLines += ""
$rulesAppendLines += "O ambiente OpenCode possui skills organizadas em multiplas fontes:"
$rulesAppendLines += ""
$rulesAppendLines += "### Skills Registradas ($($alreadyRegistered.Count))"

foreach ($name in $sortedNames) {
    $desc = $registeredDescriptions[$name]
    $rulesAppendLines += "- **$name**: $desc"
}

$rulesAppendLines += ""
$rulesAppendLines += "### Skills em .agents/skills/ ($($agentsNewForIndex.Count))"

foreach ($s in $agentsNewForIndex) {
    $rulesAppendLines += "- **$($s.Name)**"
}

$rulesAppendLines += ""
$rulesAppendLines += "### Skills Curadas (vibecoderconfigall) ($($repoNewForIndex.Count))"

foreach ($s in $repoNewForIndex) {
    $rulesAppendLines += "- **$($s.Name)**"
}

$rulesAppendLines += ""
$rulesAppendLines += "### Skills Pack ($($antigravityNewForIndex.Count + $codexNewForIndex.Count) skills de backup)"
$rulesAppendLines += "- Antigravity ($($antigravityNewForIndex.Count) skills)"
$rulesAppendLines += "- Codex ($($codexNewForIndex.Count) skills)"
$rulesAppendLines += ""
$rulesAppendLines += "**Regra:** Antes de iniciar qualquer tarefa tecnica, consulte as skills relevantes no indice em vibecoderconfigall/docs/SKILLS_INDEX.md e carregue a skill correspondente via skill load se estiver registrada, ou leia o SKILL.md diretamente."
$rulesAppendLines += ""
$rulesAppendLines += "**Diretorios de skills acessiveis:**"
$rulesAppendLines += "- .agents/skills/ -- Skills do ecossistema OpenCode"
$rulesAppendLines += "- .claude/skills/ -- Skills do ecossistema Claude"
$rulesAppendLines += "- vibecoderconfigall/skills/ -- Skills curadas do usuario"
$rulesAppendLines += "- vibecoderconfigall/skills-pack/ -- Backup de skills Antigravity/Codex"

$rulesAppend = $rulesAppendLines -join "`n"

if (-not $DryRun) {
    if (Test-Path $globalAgentRulesPath) {
        Add-Content -Path $globalAgentRulesPath -Value $rulesAppend -Encoding UTF8
        Write-Success "Regras globais dos agentes atualizadas com secao de skills"
    } else {
        Write-Warn "Arquivo global-agent-rules.md nao encontrado em: $globalAgentRulesPath"
        Write-Success "Criando novo arquivo global-agent-rules.md..."
        Set-Content -Path $globalAgentRulesPath -Value $rulesAppend -Encoding UTF8
    }
}

# ==============================================================================
# PHASE 8: GENERATE PERMISSIONS CONFIG
# ==============================================================================
Write-Banner "FASE 8: Gerando configuracao de permissoes"

$permLines = @()
$permLines += "# Permissoes necessarias para o agente OpenCode acessar skills"
$permLines += "#"
$permLines += "# Para adicionar estas permissoes ao agente OpenCode, configure no opencode.json"
$permLines += "# ou crie um agente com: opencode agent create"
$permLines += "#"
$permLines += "# Permissoes de diretorio externo necessarias:"
$permLines += ""
$permLines += "# Skills do ecossistema (.agents/skills/)"
$permLines += "# permission: external_directory"
$permLines += '# pattern: "C:\\Users\\pedro\\.agents\\skills\\*"'
$permLines += "# action: allow"
$permLines += ""
$permLines += "# Skills curadas do vibecoderconfigall"
$permLines += "# permission: external_directory"
$permLines += '# pattern: "C:\\Users\\pedro\\OneDrive\\Documentos\\00-Projetos\\10 - vibecoderconfigall\\skills\\*"'
$permLines += "# action: allow"
$permLines += ""
$permLines += "# Skills Pack - Antigravity"
$permLines += "# permission: external_directory"
$permLines += '# pattern: "C:\\Users\\pedro\\OneDrive\\Documentos\\00-Projetos\\10 - vibecoderconfigall\\skills-pack\\antigravity\\*"'
$permLines += "# action: allow"
$permLines += ""
$permLines += "# Skills Pack - Codex"
$permLines += "# permission: external_directory"
$permLines += '# pattern: "C:\\Users\\pedro\\OneDrive\\Documentos\\00-Projetos\\10 - vibecoderconfigall\\skills-pack\\codex\\*"'
$permLines += "# action: allow"
$permLines += ""
$permLines += "# Agente build.md configurado com todas as permissoes acima"
$permLines += "# Path: .config/opencode/agents/build.md"

$permissionsContent = $permLines -join "`n"
$permissionsPath = "$repoRoot\configs\opencode\permissions.example.yaml"
$permissionsDir = Split-Path $permissionsPath -Parent

if (-not $DryRun) {
    if (-not (Test-Path $permissionsDir)) {
        New-Item -ItemType Directory -Force -Path $permissionsDir | Out-Null
    }
    Set-Content -Path $permissionsPath -Value $permissionsContent -Encoding UTF8
    Write-Success "Configuracao de permissoes gerada em: $permissionsPath"
}

# ==============================================================================
# PHASE 9: GENERATE / UPDATE build.md WITH AUTO-SKILL CONFIG
# ==============================================================================
Write-Banner "FASE 9: Gerando build.md com auto-skill-loading e permissoes"

$buildMdPath = "$env:USERPROFILE\.config\opencode\agents\build.md"
$buildMdContent = @"---
mode: primary
description: >-
  Execute a solicitação com máxima precisão, responsabilidade e sem margem para
  interpretações erradas.

  Atue como um desenvolvedor full stack sênior, com experiência ampla em
  arquitetura, front-end, back-end, banco de dados, integrações, UX,
  performance, segurança e escalabilidade.

  Trabalhe com postura de engenheiro de software extremamente detalhista e
  cuidadoso, criando soluções robustas, organizadas, íntegras, manuteníveis e
  preparadas para expansão futura, sem quebrar o que já existe.

  Faça o máximo possível com autonomia, inteligência técnica e atenção total à
  estrutura do projeto.

  GESTAO AUTOMATICA DE SKILLS: Ao receber qualquer tarefa tecnica, classifique
  o dominio principal (backend, frontend, database, devops, security, design,
  architecture, testing, IA, obsidian, supabase, etc.). Escaneie proativamente
  os diretorios de skills disponiveis para encontrar SKILL.md relevantes ao
  dominio. Leia o SKILL.md das skills mais relevantes e aplique suas instrucoes
  na execucao. Skills registradas via skill load tem prioridade. Para tarefas
  sem skill correspondente, use seu conhecimento geral seguindo melhores
  praticas do dominio.

  DIRETORIOS DE SKILLS (escaneie nesta ordem):
  1. C:\Users\pedro\.agents\skills\ (skills locais do ecossistema, ~30 skills)
  2. C:\Users\pedro\OneDrive\Documentos\00-Projetos\10 - vibecoderconfigall\skills-pack\antigravity\ (skills pack Antigravity, ~1400 skills)
  3. C:\Users\pedro\OneDrive\Documentos\00-Projetos\10 - vibecoderconfigall\skills-pack\codex\ (skills pack Codex, ~1000 skills)
  4. C:\Users\pedro\.claude\skills\ (skills Claude legado)

  Para localizar skills rapidamente, use glob/**/SKILL.md nos diretorios acima
  e grep pelo nome ou descricao relevante ao dominio da tarefa.
model: opencode/minimax-m2.5-free
permission:
  "*": allow
  doom_loop: ask
  external_directory:
    "*": ask
    C:\Users\pedro\.local\share\opencode\tool-output\*: allow
    C:\Users\pedro\.agents\skills\*: allow
    C:\.agents\skills\*: allow
    C:\Users\pedro\.claude\skills\*: allow
    C:\.claude\skills\*: allow
    C:\Users\pedro\OneDrive\Documentos\00-Projetos\10 - vibecoderconfigall\skills-pack\antigravity\*: allow
    C:\Users\pedro\OneDrive\Documentos\00-Projetos\10 - vibecoderconfigall\skills-pack\codex\*: allow
    C:\Users\pedro\OneDrive\Documentos\00-Projetos\10 - vibecoderconfigall\skills\*: allow
  plan_exit: deny
  read:
    "*.env": ask
    "*.env.*": ask
    "*.env.example": allow
---
"@

if ($DryRun) {
    Write-Host "    [DryRun] Atualizaria: build.md em $buildMdPath" -ForegroundColor Yellow
} else {
    $buildMdDir = Split-Path $buildMdPath -Parent
    if (-not (Test-Path $buildMdDir)) {
        New-Item -ItemType Directory -Force -Path $buildMdDir | Out-Null
    }
    Set-Content -Path $buildMdPath -Value $buildMdContent -Encoding UTF8 -NoNewline
    Write-Success "build.md atualizado em: $buildMdPath"
}

# ==============================================================================
# PHASE 10: SUMMARY
# ==============================================================================
Write-Banner "FASE 10: Resumo da Configuracao" "Green"

Write-Host "Skills registradas no OpenCode: $($alreadyRegistered.Count)" -ForegroundColor Green
Write-Host "Skills novas identificadas: $($newSkills.Count)" -ForegroundColor Cyan
Write-Host "  Em .agents/skills/: $(($agentsNewForIndex).Count)" -ForegroundColor White
Write-Host "  Curadas (vibecoderconfigall): $(($repoNewForIndex).Count)" -ForegroundColor White
Write-Host "  Skills Pack Antigravity: $(($antigravityNewForIndex).Count)" -ForegroundColor White
Write-Host "  Skills Pack Codex: $(($codexNewForIndex).Count)" -ForegroundColor White

Write-Host "`nArquivos gerados:" -ForegroundColor Yellow
Write-Host "  - SKILLS_INDEX.md: $skillsIndexPath" -ForegroundColor White
Write-Host "  - CLAUDE.md global: $globalClaudeMdPath" -ForegroundColor White
Write-Host "  - Permissoes: $permissionsPath" -ForegroundColor White

Write-Host "`nEstado do agent prompt:" -ForegroundColor Yellow
Write-Host "  - build.md configurado com auto-skill-loading e permissoes completas" -ForegroundColor White
Write-Host "  - Proxima sessao do OpenCode usara as novas regras automaticamente" -ForegroundColor White

Write-Host "`nAcoes recomendadas:" -ForegroundColor Yellow
Write-Host "  1. Skills de skills-pack sao referenciadas por path (nao copiadas para .agents/skills/)" -ForegroundColor White
Write-Host "  2. Para buscar skills rapidamente: glob **/SKILL.md e grep nos diretorios" -ForegroundColor White
Write-Host "  3. Skills registradas podem ser carregadas com 'skill load'" -ForegroundColor White
Write-Host "  4. Skills nao registradas: ler o SKILL.md diretamente do diretorio" -ForegroundColor White

Write-Host "`nConfiguracao do OpenCode concluida!" -ForegroundColor Cyan

if ($DryRun) {
    Write-Host "`nModo DryRun: Nenhuma alteracao foi feita." -ForegroundColor Yellow
}
