# Backups n8n

Este diretório no repositório não armazena backups reais. Na VPS, use `/opt/lyvox/n8n/backups` ou destino externo protegido e excluído do Git.

## Procedimento

```bash
./scripts/backup-n8n.sh
./scripts/restore-n8n.sh /caminho/backup-aprovado
```

Confira a ajuda e o código dos scripts antes de produção. Backups devem ser consistentes, cifrados, ter checksum/manifesto, retenção definida e cópia fora da VPS. Restore exige aprovação, backup do estado atual, versão compatível, mesma `N8N_ENCRYPTION_KEY`, healthcheck e workflow de teste não destrutivo.

Não inclua archives, bancos, `.env`, encryption keys ou logs reais neste repositório.
