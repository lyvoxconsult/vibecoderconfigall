---
id: VCC-LYVOX-VPS-STRUCTURE-001
title: "Estrutura Lyvox Core na VPS"
type: architecture
domain: infrastructure
status: active
authority: derived
sensitivity: internal
updated_at: 2026-07-12
tags:
  - lyvox
  - vps
  - n8n
  - sanitized
---

# Estrutura Lyvox Core na VPS

## Princípio

O vault canônico continua em `D:\Lyvox Core\Lyvox Core`. A VPS recebe somente um snapshot sanitizado, aprovado e versionado. `Rockscore` permanece termo não confirmado e não é usado para renomear a estrutura.

```text
/opt/lyvox/
├── agent/
├── n8n/{data,backups,logs}/
├── docs/lyvox-core/sanitized/
├── skills/{codex,agents,mandatory}/
├── prompts/
├── templates/
├── scripts/
├── logs/
├── backups/
└── runtime/
```

## Regras

- `docs/lyvox-core/sanitized` é derivado e substituível; nunca recebe o vault completo.
- MOCs podem ter a estrutura preservada apenas quando todos os alvos incluídos forem permitidos.
- Skills são referenciadas por manifest e sincronizadas das origens; este diretório não é uma cópia autoritativa.
- Secrets e dados do n8n ficam fora do Git e não entram na árvore documental.
- Código/runtime prevalece sobre documentação quando houver divergência operacional.

## Wikilinks

- [[knowledge-governance]]
- [[lyvox-core-sync]]
- [[n8n-agent-architecture]]
- [[backup-restore]]
