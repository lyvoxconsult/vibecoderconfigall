# Segurança Docker

## Regras de runtime

- Instalar Docker pelo repositório oficial e manter Engine/Compose atualizados.
- Fixar versão da imagem n8n; não usar `latest` em produção.
- Executar como usuário não-root fornecido pela imagem e impedir elevação de privilégios.
- Aplicar `no-new-privileges`, remover capabilities não usadas e usar filesystem read-only quando compatível.
- Montar somente volumes necessários; nunca montar `/var/run/docker.sock`, `/`, home do operador ou vault canônico.
- Usar rede dedicada e publicar n8n em `127.0.0.1:${N8N_PORT}`.
- Definir limites de recursos, healthcheck, restart policy e rotação de logs.

## Configuração e secrets

Compose e `.env.example` podem ser versionados; `.env`, arquivos de credenciais, dados e backups não. Valores reais devem vir da VPS com permissões restritas. Variáveis de ambiente ainda podem ser inspecionadas por operadores/Docker; use secret manager quando o risco justificar.

## Imagens e atualizações

1. Revisar release notes e breaking changes.
2. Fazer backup verificável.
3. Baixar imagem com tag fixa e, quando possível, registrar digest.
4. Validar `docker compose config` sem expor valores.
5. Atualizar, conferir logs/healthcheck e testar workflow não destrutivo.
6. Em falha, restaurar a imagem anterior e os dados compatíveis.

Não habilite containers privilegiados ou Docker API TCP. Scanner de imagem e auditoria do host são complementares; ausência de achados não prova segurança.
