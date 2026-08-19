# Notas de Segurança

Este repositório segue Zero Leak: configuração reutilizável pode ser versionada; credenciais, dados e artefatos operacionais reais não podem.

## Proibido versionar ou sincronizar

- `.env` real e variantes locais.
- Tokens, senhas, cookies, JWTs, chaves SSH/TLS, connection strings e credenciais n8n.
- SQLite/PostgreSQL, dumps, volumes Docker, backups e logs reais.
- Dados pessoais, bancários, societários, jurídicos, financeiros, de clientes ou leads.
- Conteúdo Lyvox Core `confidential`, `restricted` ou `secret`.
- Workflows com dados de execução ou credenciais embutidas.

## n8n

- Defina `N8N_ENCRYPTION_KEY` forte antes da primeira inicialização e guarde-a junto ao backup, fora do Git.
- A perda da chave impede descriptografar credenciais restauradas.
- n8n atual usa user management obrigatório; `N8N_BASIC_AUTH_*` não é suportado desde 1.0.
- O Compose liga `5678` em loopback. Para acesso remoto, use túnel SSH ou HTTPS com proxy reverso.
- Não exponha Docker API, banco, Redis, Qdrant, Ollama ou serviços internos.
- Restrinja retenção de execuções e revise logs para PII.

## VPS

- Use usuário não-root com `sudo` e SSH por chave.
- Desative senha/root somente após confirmar acesso alternativo.
- Abra no UFW apenas SSH e, com proxy TLS, 80/443.
- Grupo `docker` equivale a privilégio root; limite membros.
- Atualize sistema, Docker e n8n com backup prévio e rollback definido.

## Lyvox Core

O Core original é somente leitura. Sync exige source explícito, dry-run e allowlist. Só Markdown aprovado com sensibilidade `public` ou `internal` pode ser candidato; frontmatter ausente ou inseguro bloqueia cópia. Nunca inclua `99-RESTRICTED-INDEX`, registries restritos, backups ou anexos.

`Rockscore` não aparece como alias confirmado no Core consultado. Não consolidar nomes automaticamente.

## Auditoria pré-commit

```bash
./scripts/check-secrets.sh
./scripts/check-secrets.sh --include-reference-catalog # auditoria separada; exemplos podem gerar achados
git diff --check
git status --short
```

Scanner reduz risco, não prova ausência absoluta. Revise o diff, especialmente `.json`, `.yaml`, `.md`, exports n8n e relatórios.

## Incidente

1. Remova o valor do arquivo/histórico quando necessário.
2. Revogue ou rotacione imediatamente na origem.
3. Revise logs e uso indevido.
4. Documente impacto sem repetir o secret.
