# Credenciais n8n

Nenhuma credencial real pertence a este diretório. Ele contém somente política e instruções.

## Regras

- Criar credenciais na UI/credential store do n8n.
- Manter `N8N_ENCRYPTION_KEY` estável, fora do Git e com backup cifrado separado.
- Usar contas dedicadas e scopes mínimos por integração/ambiente.
- Não inserir secrets em workflow JSON, Code nodes, `.env.example`, logs ou Telegram.
- Rotacionar credenciais após exposição, mudança de equipe ou alteração relevante de escopo.

## Integrações futuras

Telegram, Gmail, Calendar e Drive devem usar credenciais separadas. Para Google, preferir OAuth e scopes mínimos; qualquer envio, exclusão ou compartilhamento exige revisão humana do workflow. Exports de workflow contêm apenas referências às credenciais, nunca seus valores.

Backup de dados do n8n só é restaurável de forma útil com a encryption key correspondente. Teste isso em ambiente isolado.
