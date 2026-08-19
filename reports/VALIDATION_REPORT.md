# Relatório de validação

Data: 2026-07-12.

| Gate | Resultado |
|---|---|
| `bash -n` nos 30 scripts próprios fora de `skills-pack/` | PASS |
| Compose canônico `docker/n8n` com env QA | PASS |
| Compose compatível `n8n/` com env QA | PASS |
| JSON próprio fora de `skills-pack/` | PASS |
| `git diff --check` | PASS |
| Scanner operacional sem catálogo de referência | PASS |
| Scanner PowerShell operacional sem catálogo de referência | PASS |
| Dry-run Core com nota real `internal`, sem escrita | PASS; hash de seleção emitido |
| Gate de aprovação de skills/Core | PASS estático; aplicação não executada |
| `scripts/validate-repo.sh` após criação dos relatórios | PASS, zero arquivos obrigatórios ausentes |
| ShellCheck | NÃO EXECUTADO; binário não disponível localmente |
| Bootstrap Ubuntu, Docker daemon, UFW, n8n runtime e restore real | NÃO EXECUTADOS neste Windows |

## Validação pendente em VPS descartável

1. Rodar `START_N8N=0 ./bootstrap.sh` duas vezes para provar idempotência.
2. Conferir ownership/permissões em `/opt/lyvox` e manter UFW desabilitado até validar uma segunda sessão SSH.
3. Subir n8n, concluir owner onboarding, testar healthcheck e reinício da VPS.
4. Fazer backup e provar restore numa instância separada.
5. Rodar ShellCheck e scanner da imagem n8n antes de produção.
