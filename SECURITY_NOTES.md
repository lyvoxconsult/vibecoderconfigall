# Notas de Segurança

Este repositório segue Zero Leak: configuração reutilizável pode ser versionada; credenciais, dados e artefatos operacionais reais não podem.

## Proibido versionar ou sincronizar

- `.env` real e variantes locais.
- Tokens, senhas, cookies, JWTs, chaves SSH/TLS, connection strings e credenciais de servicos.
- SQLite/PostgreSQL, dumps, volumes, backups e logs reais.
- Dados pessoais, bancários, societários, jurídicos, financeiros, de clientes ou leads.
- Conteúdo Lyvox Core `confidential`, `restricted` ou `secret`.
- Workflows, exports ou configuracoes com dados de execucao ou credenciais embutidas.

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

Scanner reduz risco, não prova ausência absoluta. Revise o diff, especialmente `.json`, `.yaml`, `.md`, exports e relatórios.

## Incidente

1. Remova o valor do arquivo/histórico quando necessário.
2. Revogue ou rotacione imediatamente na origem.
3. Revise logs e uso indevido.
4. Documente impacto sem repetir o secret.
