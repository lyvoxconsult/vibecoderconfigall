# Relatório de implementação

Data: 2026-07-12. Branch: `main`. Estado: alterações locais sem commit.

## Entrega

O repositório foi ampliado como kit de bootstrap idempotente para Ubuntu/Debian, preservando a reconstrução Windows existente. A entrega inclui `bootstrap.sh`, instaladores Linux modulares, Docker Compose n8n, templates sem secrets, healthcheck, backup/restore, sync seguro de skills e Lyvox Core, agentes, prompts, documentação e validadores.

O n8n está fixado em `2.29.10`, com task runners habilitados, volume persistente e porta `5678` em loopback. O bootstrap gera `N8N_ENCRYPTION_KEY` local e não versionada. UFW é opt-in para evitar lockout SSH.

## Controles implementados

- Backup pausa n8n para consistência SQLite, usa modo `0600` e gera SHA-256 portátil.
- Restore exige `--force`, valida checksum, membros, traversal e links, cria backup preventivo e não sobe o serviço automaticamente.
- Sync de skills usa manifest, dry-run, rejeita arquivos sensíveis/symlinks e exige aprovação vinculada ao hash do conteúdo selecionado.
- Sync do Core aceita apenas Markdown allowlisted `public/internal`, remove metadados `source_*`, bloqueia PII/secrets/paths e exige aprovação pelo hash do conteúdo sanitizado.
- `skills-pack/` permanece catálogo histórico de referência e não é copiado automaticamente.
- Documentação, prompts, templates e scripts operacionais são instalados sob `/opt/lyvox`.

## Lyvox Core e Rockscore

O Core canônico `D:\Lyvox Core\Lyvox Core` foi consultado somente em leitura. O dry-run foi validado com `10-IA-AGENTES-SKILLS/Agente Central Lyvox.md`; nenhum snapshot foi persistido. Pesquisa case-insensitive por `rockscore` no Core retornou zero arquivos, portanto o termo não foi tratado como alias canônico.

## Não realizado

Nenhum `.env` real, banco, backup, sessão, log, documento restrito ou dado de cliente foi copiado. Gerenciamento, sistemas externos e o Core original não foram alterados. Provisionamento e containers não foram executados numa VPS real.
