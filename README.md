# vibecoderconfigall

Kit versionado para reconstruir em um MacBook o ambiente pessoal de agentes de desenvolvimento: Codex, Antigravity, prompts globais, skills, MCPs, referencias e regras de documentacao. O repositorio deve conter apenas configuracao reutilizavel, templates e instrucoes sanitizadas. Nao copie codigo comercial, credenciais, bancos, dumps, logs, sessoes, cookies ou documentos restritos.

## Objetivo

- Preparar um agente no macOS para copiar e configurar Codex e Antigravity.
- Reaproveitar skills locais e referencias de forma revisada, sem copiar segredos.
- Registrar boas praticas para usar Obsidian como fonte de contexto documental.
- Manter caminhos neutros: o agente deve descobrir o local real do vault e dos diretorios no Mac.
- Preservar o projeto real como fonte operacional da verdade quando houver divergencia com documentacao.

## Conteudo Principal

- `agents/`: prompts globais, regras de agentes, subagentes e prompt final para o agente do Mac.
- `configs/`: exemplos de configuracao portaveis para Antigravity, VS Code e OpenCode.
- `mcp/`: exemplos seguros de configuracao MCP.
- `skills obrigatorias/`: pack curado de skills obrigatorias e manifesto.
- `obsidian/`: blueprint neutro de documentacao e uso do Obsidian como segundo cerebro.
- `docs/`: guias de setup, governanca, seguranca e politicas sanitizadas.
- `templates/`: modelos de tarefas, planos, documentacao e relatorios.
- `scripts/`: validadores e utilitarios de manutencao do pacote.

## Quick Start no Mac

```bash
git clone https://github.com/SEU_USUARIO/vibecoderconfigall.git
cd vibecoderconfigall
pwsh ./scripts/validate-repo.ps1
```

Se `pwsh` nao estiver instalado:

```bash
bash ./scripts/validate-repo.sh
```

Depois entregue ao agente do Mac o prompt em:

```text
agents/macbook-bootstrap-prompt.md
```

## Regras de Seguranca

- Nunca versionar `.env` real.
- Nunca copiar API keys, tokens, senhas, cookies, JWTs, chaves privadas ou arquivos de sessao.
- Nunca copiar bancos, dumps, backups, volumes, logs reais ou documentos restritos.
- Usar placeholders em exemplos e configurar segredos via variaveis de ambiente locais.
- Revisar cada skill antes de instalar; o pacote bruto pode conter conteudo de terceiros, exemplos antigos ou instrucoes inadequadas.

Detalhes: [SECURITY_NOTES.md](SECURITY_NOTES.md).

## Obsidian Como Contexto

O agente deve tratar o Obsidian como camada de conhecimento e documentacao, nao como substituto do codigo. O caminho do vault deve ser informado pelo usuario ou descoberto localmente no Mac; este repositorio nao fixa caminho absoluto do Windows.

Boas praticas:

- Ler notas de visao geral, decisoes tecnicas e pendencias antes de alterar projetos relevantes.
- Registrar somente objetivo, decisoes, arquivos analisados/alterados, validacoes, riscos e pendencias.
- Evitar transcrever codigo inteiro, logs longos ou conversa bruta.
- Usar Markdown limpo, frontmatter quando fizer sentido e wikilinks.
- Quando documentacao e codigo divergirem, o codigo/testes/runtime atuais prevalecem.

## Validacao

```bash
pwsh ./scripts/validate-repo.ps1
pwsh ./scripts/check-secrets.ps1
```

ou:

```bash
bash ./scripts/validate-repo.sh
bash ./scripts/check-secrets.sh
```

O agente deve produzir evidencias atuais antes de declarar qualquer configuracao como concluida.
