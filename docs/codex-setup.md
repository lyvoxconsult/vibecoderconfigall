# Configuracao do Codex no Mac

Este guia orienta o agente a configurar Codex usando este repositorio como fonte de prompts, regras, MCPs e skills.

## Arquivos Relevantes

- `agents/codex-global-prompt.md`
- `agents/global-agent-rules.md`
- `agents/macbook-bootstrap-prompt.md`
- `mcp/codex-mcp-config.example.toml`
- `skills obrigatorias/`

## Procedimento

1. Descobrir o diretorio real de configuracao do Codex no Mac.
2. Criar backup de qualquer arquivo existente antes de sobrescrever.
3. Copiar ou mesclar o prompt global e as regras de agente.
4. Revisar o exemplo MCP e aplicar somente em arquivo local ignorado pelo Git.
5. Copiar skills obrigatorias para o destino local confirmado.
6. Rodar validadores do repositorio e scan de secrets.

## Skills Globais Atuais

O Mac deve receber o mesmo contrato operacional configurado no Windows:

- pack obrigatorio de 10 skills em `skills obrigatorias/mandatory-10-skills.md`;
- `find-skills` como descoberta obrigatoria em todo pedido;
- `devpromptarchitect` por gatilho de prompt/arquitetura de prompt;
- `sdd` por gatilho de Spec-Driven Development;
- skills obrigatorias condicionais: `project-skill-audit`, `frontend-skill`, `backend-skill`, `devops-skill`, `playwright`, `postgres-best-practices`, `react-best-practices`, `api-security-testing` e `skill-scanner`.

Para sincronizar conteudo revisado de skills no Mac, use o fluxo com dry-run e aprovacao descrito em `docs/SKILLS_INDEX.md`; nao copie catalogos brutos inteiros para superficies globais.

## Boas Praticas

- Nao assumir caminhos absolutos.
- Nao copiar `.env`, tokens, chaves ou arquivos de sessao.
- Usar Context7 ou documentacao oficial quando houver duvida de API, SDK, CLI ou MCP.
- Registrar no relatorio final os caminhos usados, arquivos alterados, comandos executados e pendencias.
- Declarar explicitamente qualquer parte nao testada.
