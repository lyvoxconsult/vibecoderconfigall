# Configuracao do Antigravity no Mac

Este guia orienta o agente a configurar Antigravity usando este repositorio como fonte de prompt global, permissoes, skills e referencias.

## Arquivos Relevantes

- `agents/antigravity-global-prompt.md`
- `agents/global-agent-rules.md`
- `configs/antigravity/config.example.json`
- `skills obrigatorias/`

## Procedimento

1. Descobrir o diretorio real de configuracao do Antigravity no Mac.
2. Criar backup de configuracoes existentes antes de sobrescrever.
3. Copiar ou mesclar o prompt global.
4. Adaptar `configs/antigravity/config.example.json` com caminhos locais confirmados.
5. Dar acesso somente aos diretorios necessarios: projetos, vault Obsidian e skills aprovadas.
6. Usar apenas skills revisadas e aprovadas individualmente; nao instalar catalogos brutos automaticamente.
7. Validar que Antigravity consegue ler os arquivos configurados.

## Boas Praticas

- Usar subagentes ou papeis separados para arquitetura, UI, seguranca e QA quando houver varias frentes.
- Validar UI com browser/screenshot quando a tarefa for visual.
- Nao declarar sucesso sem teste real.
- Registrar pendencias e limitacoes no relatorio final.
