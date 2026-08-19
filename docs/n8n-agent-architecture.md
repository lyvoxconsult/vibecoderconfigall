# Arquitetura do agente Lyvox com n8n

## Papel dos componentes

- n8n: orquestrador de eventos, integrações, filas de aprovação e auditoria; não é a fonte de verdade documental.
- Telegram: console operacional futuro, com comandos restritos e confirmação humana.
- Lyvox Core: fonte documental canônica consumida apenas por snapshot sanitizado.
- Agentes/subagentes: executores especializados com escopo, permissões e critérios de aceite explícitos.
- VPS Ubuntu + Docker: runtime isolado e reproduzível.

## Fluxo de controle

`evento -> validação -> classificação de risco -> leitura mínima de contexto -> plano -> aprovação (quando exigida) -> execução -> QA -> relatório -> notificação`

Toda ação externa, destrutiva, financeira, jurídica, de produção, que altere dados ou que amplie permissões exige aprovação humana explícita. Timeout ou ausência de resposta significa negar, não aprovar.

## Fronteiras de confiança

- Webhooks são entradas não confiáveis: autenticar, validar schema, limitar tamanho e aplicar rate limit.
- Credenciais ficam no credential store do n8n e são cifradas com `N8N_ENCRYPTION_KEY`; não entram em workflow exportado ou Git.
- Containers não recebem Docker socket nem montam o Lyvox Core canônico.
- Subagentes recebem somente o contexto e as ferramentas necessários.
- Logs usam IDs de correlação e dados redigidos; payloads sensíveis não são persistidos.

## Estados recomendados

`received`, `validated`, `awaiting_approval`, `approved`, `running`, `qa_failed`, `completed`, `rejected`, `failed`, `rolled_back`.

Idempotency keys evitam execução duplicada. Retentativas devem ter limite, backoff e dead-letter/manual review. O relatório final deve separar prova executada de validação pendente.

## MVP e evolução

MVP: instância única, SQLite persistente, acesso local/reverse proxy, backups consistentes e poucos workflows aprovados. Evolução: Postgres, filas/workers, observabilidade, segregação de ambientes e HA após medição e plano de migração.
