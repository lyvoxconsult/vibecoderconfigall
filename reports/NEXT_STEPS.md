# Próximos passos

1. Revisar o diff e fazer commit/push somente após aprovação humana; nenhum commit foi criado automaticamente.
2. Executar o bootstrap duas vezes em VPS Ubuntu descartável com `START_N8N=0`.
3. Configurar `/opt/lyvox/n8n/.env`, domínio e reverse proxy HTTPS; então subir n8n e criar owner.
4. Habilitar UFW apenas após validar a porta e manter uma segunda sessão SSH aberta.
5. Provar backup/restore em host separado e criptografar a cópia off-host.
6. Curar uma allowlist mínima do Lyvox Core e aplicar somente com hash revisado; não publicar o snapshot sem novo scan.
7. Revisar individualmente as skills necessárias; não sincronizar `skills-pack/` em massa.
8. Criar/revisar `lyvox-core-reader`; manter Rockscore como conceito não confirmado.
9. Rodar ShellCheck e scan da imagem `n8n:2.29.10` antes de produção.
