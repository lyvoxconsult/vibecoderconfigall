# Histórico de Alterações (CHANGELOG)

## [1.3.0] - 2026-07-12

### Added
- Gates de aprovação por hash para sync de skills e documentação sanitizada do Core.
- Relatórios finais de implementação, validação, security scan e próximos passos.
- `.gitattributes` para preservar LF nos scripts Linux.

### Changed
- n8n atualizado para `2.29.10`, com task runners habilitados.
- Restore endurecido com checksum, allowlist de membros, bloqueio de links/traversal e backup preventivo.
- Catálogo bruto de skills removido do bootstrap automático; instalação agora é explicitamente revisada.

## [1.2.0] - 2026-07-12

### Added
- Bootstrap modular para VPS Ubuntu/Debian com estrutura `/opt/lyvox` configurável.
- Docker Engine/Compose e runtime n8n persistente com healthcheck e bind local.
- Scripts de validação, status, backup, restore, atualização e sync seguro.
- Governança do snapshot Lyvox Core, manifest de skills, subagentes e relatórios finais.

### Changed
- README, Quick Start, prompts e segurança orientados a VPS/n8n.
- Instalador Linux reorganizado em módulos idempotentes.

### Security
- User management atual substitui Basic Auth removido do n8n.
- Sync documental usa allowlist, dry-run e bloqueio por sensibilidade.
- Templates usam placeholders; nenhum secret ou banco real foi copiado.

Todas as alterações estruturais do repositório **vibecoderconfigall** serão catalogadas neste arquivo de forma detalhada e profissional, seguindo o padrão de nomenclatura semântica.

---

## [1.0.0] - 2026-05-26

### 🚀 Inicialização do Projeto
- **Arquitetura Base:** Estrutura completa de diretórios do repositório criada com sucesso (docs, installers, configs, agents, skills, mcp, templates, obsidian, scripts, reports).
- **Documentação Principal:** Escrita dos arquivos `README.md`, `QUICK_START.md`, `SECURITY_NOTES.md` e `.gitignore` de alta restrição.
- **Ambiente Mapeado:** Rastreamento completo de ferramentas instaladas localmente (Node.js v24.14, npm v11.9, Git v2.53) e lista categorizada de extensões do VS Code ativas.
- **Configurações Seguras:** Extração segura das configurações globais de VS Code (`settings.json`), git (`.gitconfig.example`), npm e terminal para a pasta `/configs/`.
- **Inteligência Integrada:** Criação dos Prompts Globais do Antigravity e Codex (`agents/antigravity-global-prompt.md`, `agents/codex-global-prompt.md`, `agents/global-agent-rules.md`).
- **Provisionamento:** Desenvolvimento de instaladores autônomos idempotentes para Windows (`installers/windows/*.ps1`) e Linux (`installers/linux/*.sh`).
- **Automação Operacional:** Scripts de backup automático do ambiente, verificação de segredos e validação de dependências (`scripts/backup-current-environment.*`, `scripts/check-secrets.*`, `scripts/restore-*`).
- **Second Brain Blueprint:** Estruturação de modelos e arquitetura de documentação para o Obsidian integrável a Codex e Antigravity.
- **Relatórios Técnicos:** Consolidação de 10 relatórios detalhados contendo o diagnóstico de ferramentas, extensões, secrets sanitizados e validação geral.

---

## [1.1.0] - 2026-07-07

### Added
- Lyvox Core definido como Vault canônico (`D:\Lyvox Core\Lyvox Core`).
- Pack obrigatório de 10 skills para agentes e IDEs (`skills/mandatory-10-skills.md`).
- Documentação de atualização de referências de vaults antigos.
- Guias para Codex e Antigravity usarem Lyvox Core.
- Relatórios de migração e auditoria de skills (`reports/lyvox-core-migration-report.md`).
- Regra global de agentes atualizada com pack obrigatório de 10 skills.

### Changed
- Referências operacionais ao vault antigo atualizadas para Lyvox Core em 10 arquivos de skills.
- Links quebrados de SECURITY_NOTES.md corrigidos em README.md e docs/codex-setup.md.
- Regras globais de agentes reforçadas com QA, segurança, documentação e leitura do Lyvox Core.
- skills/README.md atualizado com seção obrigatória de 10 skills.

### Security
- Reforçada política Zero Leak.
- Mantida proibição de secrets e dados privados no repositório.
- Referências a caminhos antigos corrigidas para Lyvox Core.
