# Telegram como console operacional futuro

## Escopo inicial

O Telegram deve iniciar como canal de consulta, status e solicitações de baixo risco. Não habilite shell arbitrário, execução de texto livre, gestão de secrets ou ações externas destrutivas.

## Controles obrigatórios

- Criar o bot via BotFather e inserir o token somente como credencial do n8n.
- Usar allowlist de `chat_id` e, quando aplicável, `user_id`; nomes de usuário não são identidade suficiente.
- Preferir webhook HTTPS com caminho imprevisível e secret token; validar origem no workflow.
- Validar comandos por schema e catálogo fechado.
- Aplicar rate limit, deduplicação, timeout e tamanho máximo.
- Redigir logs e nunca responder com secrets, stack traces, documentos internos ou PII.

## Aprovação humana

Consultas podem responder diretamente quando não expõem dados sensíveis. Mudanças em produção, deploy, restore, envio de e-mail, acesso a clientes, alterações de configuração e qualquer ação irreversível devem gerar uma solicitação com resumo, impacto, alvo e expiração. A aprovação deve ser vinculada ao usuário autorizado e a um identificador único.

## Fluxo recomendado

1. Telegram Trigger recebe a mensagem.
2. Validar identidade, comando e replay.
3. Classificar risco e resolver o subagente adequado.
4. Buscar apenas o contexto sanitizado necessário.
5. Para alto risco, aguardar aprovação explícita.
6. Executar com credencial de menor privilégio.
7. Rodar QA e produzir relatório resumido.
8. Responder com status e ID de correlação, sem conteúdo sensível.

Gmail, Calendar e Drive são integrações futuras. Configure OAuth por usuário/serviço, scopes mínimos e revisão humana antes de ativar workflows que enviem, apaguem ou compartilhem dados.
