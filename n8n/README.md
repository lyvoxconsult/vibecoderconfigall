# n8n no runtime Lyvox

O compose canônico está em `docker/n8n/docker-compose.yml`; `n8n/docker-compose.yml` é uma cópia de compatibilidade. Use um único deles por execução para não criar stacks concorrentes.

## Preparação

```bash
cd /opt/lyvox/n8n
cp .env.example .env
openssl rand -hex 32
chmod 600 .env
```

Cole a saída somente em `N8N_ENCRYPTION_KEY` no `.env` local. Ajuste host, protocolo e URLs. Nunca commite esse arquivo.

## Subir e acessar

```bash
docker compose config
docker compose up -d
docker compose ps
docker compose logs --tail=100 n8n
```

Por padrão a porta é publicada apenas em `127.0.0.1:5678`. Para o primeiro acesso, use túnel SSH ou configure reverse proxy HTTPS. No navegador, crie o owner account nativo do n8n.

> `N8N_BASIC_AUTH_*` não deve ser usado: Basic Auth foi removido desde o n8n 1.0. A proteção atual combina owner account nativo, senha forte/2FA quando disponível, encryption key persistente e HTTPS.

## Webhooks e proxy

Em produção, configure `N8N_HOST`, `N8N_PROTOCOL=https`, `N8N_EDITOR_BASE_URL` e `N8N_WEBHOOK_URL` com o domínio público. O proxy deve encaminhar headers corretos e ser o único serviço exposto. Não publique a porta 5678 diretamente.

## Operação

- Healthcheck: `/opt/lyvox/scripts/healthcheck.sh`.
- Status: `/opt/lyvox/scripts/print-status.sh`.
- Backup: `/opt/lyvox/scripts/backup-n8n.sh`.
- Restore: `/opt/lyvox/scripts/restore-n8n.sh ARQUIVO --force`, após aprovação e em janela de manutenção.
- Atualização: backup, revisão de release notes, alteração da tag fixa, pull/up, healthcheck e teste não destrutivo.

Credenciais são criadas na UI do n8n e permanecem fora do Git. Consulte `credentials/README.md`, `workflows/README.md` e `backups/README.md`.

Documentação oficial: [Docker](https://docs.n8n.io/hosting/installation/docker/), [reverse proxy/webhooks](https://docs.n8n.io/hosting/configuration/configuration-examples/webhook-url/), [security audit](https://docs.n8n.io/hosting/securing/security-audit/).
