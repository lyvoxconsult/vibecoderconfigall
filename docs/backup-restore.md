# Backup e restore

## O que proteger

- volume persistente do n8n, incluindo banco SQLite no MVP;
- `N8N_ENCRYPTION_KEY` em cofre separado;
- `.env` real em backup cifrado e com acesso restrito;
- workflows exportados sem credenciais, quando usados como artefato adicional;
- configuração Compose e documentação versionadas no Git.

Workflow JSON isolado não substitui backup da instância. Sem a mesma encryption key, credenciais persistidas podem ficar irrecuperáveis.

## Backup consistente

1. Validar espaço, destino e permissões.
2. Fazer backup com `scripts/backup-n8n.sh`; para SQLite, pausar o container ou usar método consistente implementado pelo script.
3. Gerar checksum e manifesto sem secrets.
4. Cifrar antes de enviar para armazenamento externo.
5. Aplicar retenção e manter ao menos uma cópia fora da VPS.
6. Testar restauração periodicamente em ambiente isolado.

## Restore

1. Confirmar aprovação, snapshot alvo, versão do n8n e impacto da indisponibilidade.
2. Fazer backup de segurança do estado atual.
3. Parar a instância e executar `scripts/restore-n8n.sh` em destino controlado.
4. Restaurar a encryption key correta sem registrá-la em logs.
5. Subir a mesma versão compatível, validar healthcheck, login, credenciais e um workflow não destrutivo.
6. Só então reabrir tráfego e registrar evidências.

## RPO, RTO e validação

Defina RPO/RTO com o owner antes da produção. O padrão inicial recomendado é backup diário, retenção diária/semanal/mensal e teste de restore trimestral, ajustados ao volume e criticidade. Um arquivo existente só é backup válido depois de checksum e restore testado.
