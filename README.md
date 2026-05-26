# vibecoderconfigall

O **vibecoderconfigall** é o seu repositório de backup central, documentação, automação e reconstrução completa do seu ambiente de trabalho de alta performance. Ele consolida de maneira estruturada todas as suas configurações de IDEs, perfis de terminal, MCPs, Prompts Globais, Agentes e Skills reutilizáveis do Antigravity, Codex e demais ferramentas de desenvolvimento.

Este repositório foi arquitetado para ser independente de dados privados ou código-fonte comercial dos seus projetos, servindo tanto para restaurar o seu próprio ambiente rapidamente em qualquer máquina (Windows ou Linux) quanto para servir de blueprint de referência técnica premium para a comunidade.

---

## 🚀 Objetivos Principais

1. **Portabilidade:** Permitir que você configure o seu ambiente de trabalho completo em um novo notebook ou máquina em poucos minutos.
2. **Automação:** Instalação automatizada via scripts idempotentes (PowerShell para Windows e Bash para Linux) de ferramentas fundamentais, gerenciadores de pacotes e extensões.
3. **Consistência Operacional:** Centralização das regras, prompts e automações do Antigravity e Codex para garantir a mesma alta performance em qualquer repositório.
4. **Segundo Cérebro Integrado:** Modelar e guiar a estruturação de documentação, decisões de arquitetura e notas de aprendizado usando o Obsidian em simbiose com as IAs de codificação.
5. **Segurança por Padrão (Security by Design):** Mecanismos automatizados e regras de git para impedir totalmente a exposição acidental de credenciais e segredos (API Keys, bancos de dados, chaves SSH).

---

## 📁 Estrutura do Repositório

```text
vibecoderconfigall/
├── README.md                           # Documentação geral do ecossistema
├── QUICK_START.md                       # Comandos e guias rápidos para bootstrap
├── SECURITY_NOTES.md                   # Diretrizes cruciais de segurança e higienização
├── CHANGELOG.md                        # Histórico de alterações e melhorias do ambiente
├── .gitignore                          # Regras restritas para evitar vazamento de dados
├── .env.example                        # Template limpo de variáveis de ambiente do sistema
│
├── docs/                               # Manuais e documentações auxiliares
│   ├── overview.md                     # Visão geral da arquitetura de desenvolvimento
│   ├── windows-setup.md                # Passo a passo de instalação no Windows
│   ├── linux-setup.md                  # Passo a passo de instalação no Linux
│   ├── manual-steps.md                 # Etapas que não podem ser automatizadas
│   ├── tools-inventory.md              # Inventário de ferramentas do ambiente
│   ├── extensions.md                   # Catálogo categorizado de extensões de IDE
│   ├── agents-overview.md              # Mapeamento do ecossistema de subagentes
│   ├── skills-overview.md              # Glossário e definições de skills para IAs
│   ├── mcp-overview.md                 # Funcionamento e extensões de Model Context Protocol
│   ├── codex-setup.md                  # Guia de parametrização e prompts do Codex
│   ├── antigravity-setup.md            # Guia de parametrização e prompts do Antigravity
│   ├── obsidian-structure.md           # Guia de organização do Segundo Cérebro
│   └── troubleshooting.md              # Solução de problemas conhecidos
│
├── installers/                         # Scripts de instalação e provisionamento
│   ├── windows/                        # Provisionamento nativo em PowerShell (Win11)
│   │   ├── install.ps1                 # Script orquestrador principal
│   │   ├── install-tools.ps1           # Instalação de CLIs e ferramentas (Winget)
│   │   ├── install-node.ps1            # Setup otimizado do ecossistema Node.js
│   │   ├── install-python.ps1          # Setup otimizado do ecossistema Python
│   │   ├── install-extensions.ps1      # Instalação em lote de extensões no VS Code/Cursor
│   │   ├── configure-git.ps1           # Setup e otimização do Git global
│   │   ├── configure-codex.ps1         # Backup/restauração e setup do Codex local
│   │   ├── configure-antigravity.ps1   # Backup/restauração e setup do Antigravity local
│   │   └── validate.ps1                # Validação de integridade do ambiente Windows
│   │
│   └── linux/                          # Provisionamento nativo em Bash (Ubuntu/Debian/WSL)
│       ├── install.sh                  # Script orquestrador principal Linux
│       ├── install-tools.sh            # Instalação via apt/pacman/curl
│       ├── install-node.sh             # Instalação do Node/npm/pnpm via FNM
│       ├── install-python.sh           # Setup de Python/pip/uv via Pyenv ou nativo
│       ├── install-extensions.sh       # Script bash de instalação de extensões
│       ├── configure-git.sh            # Configuração do Git e aliases em bash
│       ├── configure-codex.sh          # Injeção de prompts e configurações no Codex Linux
│       ├── configure-antigravity.sh    # Injeção de prompts e configurações no Antigravity Linux
│       └── validate.sh                 # Validação de integridade do ambiente Linux
│
├── configs/                            # Arquivos de configurações reais livres de segredos
│   ├── codex/                          # Configurações brutas de agentes e subagentes Codex
│   ├── antigravity/                    # Regras de comportamento e parâmetros locais
│   ├── vscode/                         # settings.json, keybindings.json e snippets
│   ├── cursor/                         # Configurações e diretrizes de IA do Cursor
│   ├── git/                            # .gitconfig higienizado, templates e aliases globais
│   ├── npm/                            # Configurações globais de npm (.npmrc)
│   ├── python/                         # Otimizações de pip/uv globais
│   ├── powershell/                     # Profile.ps1, prompts e funções customizadas do PowerShell
│   ├── terminal/                       # JSON de configuração do Windows Terminal e Zsh
│   └── mcp/                            # Exemplo seguro de arquivos de hosts e portas de MCPs
│
├── agents/                             # Prompts sistêmicos e instruções de comportamento
│   ├── global-agent-rules.md           # Regras universais aplicadas às IAs
│   ├── antigravity-global-prompt.md    # System Prompt customizado do Antigravity
│   ├── codex-global-prompt.md          # System Prompt customizado do Codex
│   ├── subagents/                      # Instruções de contexto para agentes especialistas
│   └── templates/                      # Templates de tarefas e instruções de delegação
│
├── skills/                             # Arquivos MD contendo documentações de "Skills"
│   ├── README.md                       # Como registrar e carregar skills nas IAs
│   ├── global-skills.md                # Skills fundamentais e comportamentais
│   ├── frontend-skills.md              # Otimização e arquitetura de interfaces UI/UX
│   ├── backend-skills.md               # Padrões de desenvolvimento de APIs robustas
│   ├── design-skills.md                # Skills visuais e frameworks de design system
│   ├── database-skills.md              # Interações e migrações seguras com bancos (Supabase)
│   ├── devops-skills.md                # Fluxos de deployment e orquestração (Vercel/Docker)
│   ├── qa-skills.md                    # Automatizações e estratégias de testes unitários/e2e
│   ├── security-skills.md              # Auditorias preventivas de segurança
│   └── documentation-skills.md         # Escrita técnica e manutenção de repositórios
│
├── mcp/                                # Configuração e setup de Model Context Protocol
│   ├── README.md                       # Como conectar novos servidores de contexto
│   ├── mcp-config.example.json         # Configuração higienizada de MCP no VS Code/Cursor
│   ├── codex-mcp-config.example.toml   # Configuração higienizada de MCP no Codex
│   └── servers/                        # Exemplos de setup de servidores de arquivos, web, etc.
│
├── templates/                          # Blueprints e estruturas prontas para novos projetos
│   ├── project-readme-template.md      # Template de README profissional
│   ├── env-template.env                # Estrutura base de arquivo .env
│   ├── agent-task-template.md          # Template de tarefa delegada para IAs
│   ├── bug-report-template.md          # Registro e análise técnica de erros
│   ├── implementation-plan-template.md # Template para planos de execução
│   ├── validation-report-template.md   # Modelo de relatório de conformidade técnica
│   └── documentation-template.md       # Blueprint de documentação geral
│
├── obsidian/                           # Blueprint e notas estruturadas extraídas do seu cofre
│   ├── extracted-important-notes.md    # Notas de arquitetura e IA refinadas
│   ├── documentation-architecture.md   # Arquitetura de registro do cérebro digital
│   ├── project-knowledge-base-template.md # Como estruturar a base de dados de projetos
│   └── second-brain-structure.md       # Organização operacional de pastas e links no Obsidian
│
├── scripts/                            # Scripts utilitários de manutenção do ambiente
│   ├── backup-current-environment.ps1 # Varre o ambiente ativo e exporta atualizações
│   ├── backup-current-environment.sh  # Equivalente para ambientes Linux
│   ├── restore-windows.ps1             # Orquestra a restauração total no Windows
│   ├── restore-linux.sh                # Orquestra a restauração total no Linux
│   ├── check-secrets.ps1               # Analisa se há exposição de tokens no código
│   ├── check-secrets.sh                # Análise preventiva de secrets para Linux
│   ├── validate-repo.ps1               # Testa a integridade dos arquivos e links do repo
│   └── validate-repo.sh                # Validação em bash para pipeline
│
└── reports/                            # Resultados das análises e varreduras
    ├── scan-report.md                  # Sumário do escaneamento do ambiente original
    ├── tools-detected.md               # Detalhamento técnico de versões e CLIs locais
    ├── extensions-detected.md          # Extensões ativas mapeadas categoricamente
    ├── configs-detected.md             # Análise de configurações globais ativas
    ├── agents-detected.md              # Agentes e Sidecars ativamente rastreados
    ├── skills-detected.md              # Skills ativas mapeadas em `.gemini/config`
    ├── mcp-detected.md                 # Servidores e ferramentas de MCP em uso local
    ├── secrets-sanitized.md            # Auditoria de segredos limpos e removidos
    ├── validation-report.md            # Diagnóstico da execução dos scripts de teste
    └── pending-manual-actions.md       # Ações necessárias a serem feitas de forma manual
```

---

## 🛠️ Requisitos Mínimos Recomendados

### Windows:
- Windows 11 com **PowerShell 7+** (ou PowerShell nativo com privilégios de execução).
- Gerenciador de pacotes **Winget** instalado e funcional.
- Conexão de internet ativa para download dos pacotes e dependências.

### Linux / WSL:
- Ubuntu 20.04 LTS ou superior (ou qualquer distro baseada em Debian/Arch).
- Acesso de `sudo` do usuário atual.
- `curl`, `git` e `bash` disponíveis de forma nativa.

---

## 🛡️ Segurança e Privacidade
Este projeto segue a filosofia **Zero Leak**. Nenhuma credencial física deve entrar neste repositório. Em caso de dúvidas sobre se um arquivo possui dados secretos, o script `scripts/check-secrets.ps1` pode ser rodado preventivamente para varrer a pasta. 

Sempre verifique as instruções contidas em [SECURITY_NOTES.md](file:///C:/Users/pedro/OneDrive/Documentos/00-Projetos/vibecoderconfigall/SECURITY_NOTES.md).

---

## 📈 Contribuição e Evolução
Sempre que você descobrir uma nova extensão vital, uma nova skill corporativa ou otimizar seu prompt de sistema do Antigravity, rode:
```powershell
.\scripts\backup-current-environment.ps1
```
Isso atualizará os diretórios `/configs/`, `/reports/` e o inventário de ferramentas sem qualquer risco de vazamento de secrets, permitindo que você realize o commit e mantenha o seu repositório sincronizado.

---

*vibecoderconfigall — O cérebro técnico e operacional de desenvolvimento sob seu total controle.*
