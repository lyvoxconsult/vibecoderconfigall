# Política de secrets

## Nunca versionar

Senhas, tokens, API keys, cookies, JWTs, chaves privadas, connection strings, credenciais OAuth, `.env` real, banco, arquivos do credential store, logs sensíveis e dados de clientes. Use somente `.env.example` com placeholders inequivocamente inválidos.

## Criação e armazenamento

- Armazenar secrets fora do Git, com owner dedicado e modo `0600` quando aplicável.
- Usar credenciais nativas das ferramentas e scopes mínimos; não inserir tokens em código, prompts, exports ou JSON versionado.
- Separar credenciais de desenvolvimento e produção.

## Uso e logs

Secrets não aparecem em argumentos de linha de comando, relatórios, screenshots, tickets ou mensagens Telegram. Redigir headers, query strings, payloads e erros antes de logar. Não usar valores reais em testes.

## Rotação e incidente

Rotacionar em mudança de equipe, suspeita de exposição, alteração de escopo ou ciclo definido pelo owner. Em incidente: revogar primeiro, preservar evidência segura, substituir, verificar uso indevido, limpar histórico quando necessário e documentar sem reproduzir o segredo.

## Varredura

Executar `scripts/check-secrets.sh` antes de commit/deploy e revisar manualmente arquivos novos, exports e backups. Scanner pode produzir falso negativo; aprovação humana continua obrigatória. Se um segredo for detectado, não o inclua em relatórios nem no chat.
