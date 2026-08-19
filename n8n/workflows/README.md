# Workflows n8n

Este diretório aceita somente exports sanitizados, sem credenciais, secrets, PII ou payloads reais.

## Convenções

- Nome: `lyvox-<dominio>-<acao>-vN`.
- Incluir objetivo, owner, trigger, entradas/saídas, risco, idempotência, timeout, retentativas e rollback.
- Separar desenvolvimento e produção; não ativar automaticamente após import.
- Credenciais são selecionadas manualmente na instância de destino.
- Ações externas ou destrutivas exigem aprovação humana explícita.

## Revisão antes de versionar

1. Desativar workflow e remover pinned/test data.
2. Verificar Code nodes, URLs, headers, query strings e expressões.
3. Confirmar ausência de IDs pessoais, tokens e credential payloads.
4. Rodar o scanner de secrets.
5. Revisar diff e documentar validação real.

Imports devem ser tratados como código não confiável: revisar todos os nodes, community nodes e permissões antes da ativação.
