# Relatório de security scan

Data: 2026-07-12.

## Resultado operacional

`scripts/check-secrets.sh` e `scripts/check-secrets.ps1`: PASS nos arquivos operacionais do repositório. Ambos cobrem chaves privadas, AWS, GitHub, OpenAI, Slack, Telegram, JWT, URLs de banco e assignments suspeitos. Nenhum `.env` real, chave, banco, dump, log ou backup foi detectado nessa superfície.

O scanner exclui `skills-pack/` por padrão porque esse diretório é um catálogo histórico de terceiros e tornava o gate operacional lento e ruidoso. No snapshot de 2026-07-12, uma busca separada com `rg` e o conjunto de padrões fortes documentado encontrou assinaturas em 28 arquivos do catálogo, concentradas em documentação, exemplos e manifest de instalação. Outros conjuntos de padrões podem produzir contagem diferente. Isso não é tratado como prova de credenciais reais nem como aprovação do catálogo. Nenhuma dessas skills é instalada automaticamente; qualquer uso exige revisão individual, scanner, ausência de symlinks e aprovação por hash.

## Controles confirmados

- Templates usam placeholders ou valores vazios; `DATABASE_URL` genérica foi zerada.
- n8n publica somente em `127.0.0.1` e não usa Basic Auth removido.
- UFW é opt-in e exige porta SSH explícita na faixa 1–65535.
- Backups têm modo restrito e aviso de material sensível.
- Restore exige sidecar SHA-256 e rejeita checksum divergente, caminho absoluto, traversal, membro inesperado e links.
- Core original é read-only; sync é deny-by-default, sanitizado e aprovado por hash.
- Skills são selecionadas pelo manifest; catálogo bruto não é copiado.

## Riscos residuais

- As 28 assinaturas do catálogo histórico precisam de classificação manual antes de qualquer distribuição; o catálogo não pode ser considerado security-clean.
- A imagem n8n ainda não foi baixada nem escaneada.
- Backups reais conterão encryption key e banco; exigem criptografia e armazenamento off-host.
- UFW, SSH, reverse proxy HTTPS e permissões do host precisam de prova na VPS.
- Scanners reduzem risco, mas não provam ausência absoluta de segredo.
