# Hardening da VPS Ubuntu

## Baseline antes de publicar

- Atualizar o sistema e habilitar atualizações automáticas de segurança.
- Criar usuário administrativo nominal, usar `sudo` e bloquear login SSH direto de `root`.
- Usar chaves SSH modernas; desabilitar senha após confirmar uma segunda sessão funcional.
- Restringir SSH por IP/VPN quando possível e ativar proteção contra brute force.
- Configurar UFW com política deny inbound/allow outbound.
- Manter n8n ligado a `127.0.0.1`; expor somente 80/443 pelo reverse proxy.
- Habilitar sincronização de tempo, logs com rotação e alertas de disco/CPU/memória.

Exemplo de portas: `22/tcp` restrita à administração, `80/tcp` apenas para redirecionamento/ACME e `443/tcp` para HTTPS. Não exponha `5678`, Docker API, banco, Redis, Ollama ou Qdrant diretamente à internet.

## n8n

O Basic Auth do n8n foi removido desde a linha 1.0. Use o owner account nativo criado no primeiro acesso, senha forte, 2FA quando disponível, `N8N_ENCRYPTION_KEY` persistente e reverse proxy HTTPS. Sem TLS e hostname válido, mantenha a instância acessível apenas por localhost/túnel SSH.

## Permissões e dados

- Código/configuração versionada: leitura pelo operador e escrita somente pelo responsável pelo deploy.
- `.env`, chaves e backups: `0600`; diretórios sensíveis: `0700`.
- Dados do n8n não devem ser world-readable.
- Não montar o Docker socket no n8n.
- Backups devem ser cifrados, testados e mantidos fora da VPS.

## Operação

Antes de alterar SSH/UFW, confirme console de recuperação do provedor e mantenha uma sessão aberta. Faça mudanças em etapas, valide acesso, registre evidência e defina rollback. Hardening do provedor, DNS, TLS, alertas e restore real exigem validação na VPS.
