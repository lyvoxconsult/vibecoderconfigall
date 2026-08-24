# Regras Universais dos Agentes

Estas regras valem para qualquer agente atuando com este pacote: Codex, Antigravity, OpenCode, Cursor ou outro agente de desenvolvimento.

## 1. Seguranca e Nao Vazamento

- Nao copie codigo proprietario, regras de negocio sensiveis, bancos, dumps, logs reais, sessoes, cookies ou documentos restritos para este repositorio.
- Nunca grave chaves de API, tokens, senhas, connection strings ou credenciais em arquivos versionados.
- Use placeholders em exemplos e variaveis locais fora do Git.
- Antes de copiar qualquer skill ou configuracao, leia o arquivo e verifique se ha instrucao perigosa, segredo ou caminho herdado.

## 2. Caminhos Portaveis

- Nao presuma caminhos absolutos.
- Descubra no ambiente local os destinos reais de projetos, vault Obsidian, Codex, Antigravity, MCPs e skills.
- Se um caminho nao puder ser descoberto com seguranca, pergunte ao usuario.
- Em arquivos versionados, use placeholders como `<PROJECTS_ROOT>`, `<OBSIDIAN_VAULT>`, `<CODEX_CONFIG>` e `<ANTIGRAVITY_CONFIG>`.

## 3. Engenharia de Qualidade

- Analise a estrutura real antes de editar.
- Prefira mudancas pequenas, reversiveis e alinhadas ao padrao existente.
- Preserve funcionalidades existentes.
- Use bibliotecas e recursos nativos antes de criar abstracoes novas.
- Nao adicione dependencias sem necessidade tecnica clara.

## 4. Skills

- Carregue o pack obrigatorio antes de tarefas tecnicas:
  1. `ponytail`
  2. `subagent-driven-development`
  3. `audit-context-building`
  4. `concise-planning`
  5. `architecture-skill`
  6. `security-skill`
  7. `code-quality-skill`
  8. `testing-skill`
  9. `uxui-principles`
  10. `obsidian-markdown`
- Use `multiagent-qa-orchestration` em tarefas relevantes, incluindo QA final.
- Use `find-skills` como descoberta obrigatoria em todo pedido: primeiro skills locais, depois busca externa somente se o catalogo local nao cobrir bem.
- Use `devpromptarchitect` quando a tarefa for criar, melhorar ou estruturar prompts para agentes.
- Some skills obrigatorias condicionais por dominio:
  - `project-skill-audit` para setup/auditoria de skills e padroes recorrentes.
  - `frontend-skill` para UI/frontend/React/Next/Tailwind/shadcn/acessibilidade.
  - `backend-skill` para APIs, servicos, persistencia, auth, migrations e integracoes.
  - `devops-skill` para deploy, Docker, CI/CD, runtime, env vars, Vercel, infra e producao.
  - `playwright` para validacao real em navegador, fluxos UI, responsividade, screenshots e E2E funcional.
  - `postgres-best-practices` para Postgres, Supabase, SQL, RLS, indices e performance de banco.
  - `react-best-practices` para React/Next.js, data fetching, bundle, renderizacao e performance.
  - `api-security-testing` para seguranca REST/GraphQL, auth, autorizacao, rate limit e input validation.
  - `skill-scanner` antes de instalar/adotar/recomendar skill externa ou desconhecida.
- Nao instale o pacote bruto de skills inteiro sem revisao e aprovacao.

## 5. Obsidian

- Obsidian e fonte de contexto e memoria tecnica, nao substitui o codigo.
- O vault deve ser informado pelo usuario ou descoberto localmente; este pacote nao fixa caminho.
- Antes de alterar projeto relevante, leia notas de visao geral, decisoes tecnicas e pendencias quando existirem.
- Ao final de trabalho relevante, registre objetivo, decisoes, arquivos analisados/alterados, validacoes, riscos e pendencias.
- Nao cole codigo inteiro, logs extensos, segredos ou transcricoes de chat nas notas.
- Quando documentacao e codigo divergirem, codigo, testes, manifests e runtime atuais prevalecem.

## 6. Validacao

- Nao declare sucesso sem executar validacoes reais.
- Registre comandos executados e resultado.
- Se algo nao foi testado, declare exatamente o que faltou, motivo, risco e validacao manual recomendada.
- Use scan de secrets antes de concluir alteracoes de configuracao.

## 7. Comunicacao

- Responda em pt-BR.
- Seja direto, tecnico e objetivo.
- Separe claramente: feito, validado, pendente e nao testado.
