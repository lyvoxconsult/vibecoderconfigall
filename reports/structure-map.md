# 🗺️ Mapa Estrutural do Repositório - vibecoderconfigall

> **Atualizado em:** 2026-05-26

---

## Árvore do Projeto

```
vibecoderconfigall/
├── README.md                    # Documentação principal
├── QUICK_START.md               # Guia de início rápido
├── SECURITY_NOTES.md            # Regras de segurança
├── CHANGELOG.md                 # Registro de mudanças
├── .gitignore                   # Bloqueio de arquivos sensíveis
├── .env.example                 # Template de variáveis de ambiente
│
├── agents/                      # Prompts e regras globais de agentes IA
│   ├── antigravity-global-prompt.md
│   ├── codex-global-prompt.md
│   └── global-agent-rules.md
│
├── configs/                     # Configurações de ferramentas (sanitizadas)
│   └── vscode/
│       └── settings.json
│
├── docs/                        # Documentação operacional
│   ├── antigravity-setup.md
│   ├── codex-setup.md
│   └── obsidian-structure.md
│
├── installers/                  # Scripts de instalação automatizada
│   ├── windows/                 # PowerShell (.ps1)
│   │   ├── install.ps1          # Orquestrador principal
│   │   ├── install-tools.ps1
│   │   ├── install-node.ps1
│   │   ├── install-python.ps1
│   │   ├── install-extensions.ps1
│   │   ├── configure-git.ps1
│   │   ├── configure-antigravity.ps1
│   │   ├── configure-codex.ps1
│   │   └── validate.ps1
│   └── linux/                   # Bash (.sh)
│       ├── install.sh           # Orquestrador principal
│       ├── install-tools.sh
│       ├── install-node.sh
│       ├── install-python.sh
│       ├── install-extensions.sh
│       ├── configure-git.sh
│       ├── configure-antigravity.sh
│       ├── configure-codex.sh
│       └── validate.sh
│
├── mcp/                         # Configurações de MCP servers
│   ├── mcp-config.example.json
│   └── codex-mcp-config.example.toml
│
├── reports/                     # Relatórios de auditoria
│   ├── environment-audit.md
│   ├── security-report.md
│   ├── tools-inventory.md
│   └── structure-map.md         # (este arquivo)
│
├── scripts/                     # Scripts utilitários de manutenção
│   ├── check-secrets.ps1 / .sh
│   ├── backup-current-environment.ps1 / .sh
│   ├── restore-from-backup.ps1 / .sh
│   └── validate-repo.ps1 / .sh
│
├── skills/                      # Catálogo e referências de skills
│   ├── global-skills.md
│   ├── frontend-skills.md
│   ├── backend-skills.md
│   ├── devops-skills.md
│   └── specialized-skills.md
│
└── templates/                   # Templates reutilizáveis
    ├── readme-template.md
    ├── bug-report-template.md
    └── implementation-plan-template.md
```

---

## Contagem de Arquivos

| Diretório | Arquivos |
|---|---|
| `agents/` | 3 |
| `configs/vscode/` | 1 |
| `docs/` | 3 |
| `installers/windows/` | 9 |
| `installers/linux/` | 9 |
| `mcp/` | 2 |
| `reports/` | 4 |
| `scripts/` | 8 |
| `skills/` | 5 |
| `templates/` | 3 |
| Raiz | 5 |
| **Total** | **~52 arquivos** |

---

## Responsabilidades por Camada

| Camada | Descrição |
|---|---|
| **Documentação** | README, QUICK_START, SECURITY_NOTES, CHANGELOG, docs/ |
| **Automação** | installers/ (Win + Linux), scripts/ |
| **Inteligência** | agents/, skills/, mcp/ |
| **Configuração** | configs/, .env.example |
| **Auditoria** | reports/, scripts/check-secrets |
