# 🛡️ Regras Universais dos Agentes (GLOBAL_AGENT_RULES)

Estas regras operacionais são universais e devem ser rigorosamente respeitadas por qualquer agente de IA (Antigravity, Codex, Cursor) atuando dentro deste ambiente de trabalho. A falha no cumprimento destas regras constitui uma falha operacional séria.

---

## 🚫 1. Regra de Não-Copiar Projetos e Segurança (Zero Leak)
- **Proibição Absoluta:** É expressamente proibido copiar qualquer código-fonte proprietário, regras de negócio ou estrutura interna de pastas (`src`, `app`, `pages`, `components`, `api`, `server`) de projetos existentes no diretório `00-Projetos` para dentro do repositório `vibecoderconfigall`.
- **Foco em Templates:** Sempre que encontrar um padrão útil em um projeto comercial (ex: conexão Supabase ou rota express), você deve abstrair esse padrão, limpando-o completamente e gerando uma documentação conceitual, template de código-fonte genérico ou blueprint reutilizável.
- **Proteção a Segredos:** Você NUNCA deve copiar chaves de API, senhas, tokens de acesso ou strings de conexão reais de banco. Sempre utilize placeholders (`INSIRA_SUA_CHAVE_AQUI`) e guie o usuário para o uso seguro de arquivos `.env`.

---

## 🏗️ 2. Arquitetura e Engenharia de Qualidade
- **Pensar Antes de Codar:** Antes de realizar qualquer modificação em arquivos de código ou documentação, realize um diagnóstico minucioso. Entenda o contexto global, rastreie dependências e verifique se há potenciais efeitos colaterais.
- **Evitar Gambiarras:** Soluções temporárias ou código duplicado não são aceitáveis. Busque construir código modular, desacoplado, limpo, de fácil manutenção e em estrita conformidade com as diretrizes e frameworks do projeto.
- **Validação de Entrada e Saída:** Trate erros de forma explícita, valide tipos e payloads de chamadas utilizando schemas (Zod ou Pydantic) e sanitize entradas de dados do usuário final.

---

## 🧪 3. Validação Preventiva e Sucesso Técnico
- **Proibição de Simular Sucesso:** É proibido declarar sucesso ou relatar a conclusão de uma tarefa de forma verbal sem ter executado testes reais, validado compilações ou inspecionado os arquivos resultantes.
- **Auditoria de Conformidade:** Ao terminar uma tarefa complexa, rode scripts de validação de dependências e syntax lints para garantir a robustez e a integridade da entrega.

---

## 📝 4. Comunicação e Documentação
- **Escrita Técnica Concisa:** Evite discursos longos ou explicações óbvias. Responda de forma profissional, direta e acionável.
- **Atualização de Documentos Auxiliares:** Sempre que for pertinente, atualize a documentação técnica relevante (Obsidian, Readme, etc) registrando as mudanças e decisões arquiteturais.
- **Idiomas:** Toda a comunicação, relatórios e documentações locais com o usuário devem ser redigidos em **Português do Brasil (pt-BR)**.

---

## 5. Ecossistema de Skills OpenCode (Auto-Skill-Loading)

O ambiente OpenCode possui um ecossistema completo de skills. O agente **build** ja esta configurado em `.config/opencode/agents/build.md` com permissoes de leitura para todos os diretorios abaixo e instrucoes de auto-escaneamento.

### Skills Registradas (10) — via `skill load`
- **defuddle**: Extracao de markdown limpo de paginas web
- **devpromptarchitect**: Arquitetura e planejamento de prompts
- **json-canvas**: Criacao e edicao de JSON Canvas (.canvas)
- **multiagent-qa-orchestration**: Orquestracao de multiplos agentes com QA
- **obsidian-bases**: Criacao de Bases (.base) no Obsidian
- **obsidian-cli**: Interacao com vault Obsidian via CLI
- **obsidian-markdown**: Markdown com sintaxe Obsidian
- **rbac-access-control-architect**: Controle de acesso por funcao (RBAC)
- **supabase**: Tudo sobre Supabase (Auth, DB, Storage, Functions)
- **supabase-postgres-best-practices**: Otimizacao de PostgreSQL

### Skills em .agents/skills/ (30)
- agent-fullstack, ai-automation, architecture, backend, backend-skills
- code-quality, database-skills, design-skills, devops, devops-skills
- documentation-skills, frontend, frontend-skills, global-skills
- highermind-code-skills, hm-deploy, hm-designer, hm-engineer, hm-init
- hm-qa, hm-security, monitoring, multiagent-qa-orchestration
- qa-skills, rbac-access-control-architect, security, security-skills
- testing, devpromptarchitect, obsidian (contem 5 sub-skills)

### Skills Curadas (9) — em .agents/skills/
- backend-skills, database-skills, design-skills, devops-skills
- documentation-skills, frontend-skills, global-skills, qa-skills, security-skills

### Skills Pack Antigravity (~1426 skills)
- Path: `vibecoderconfigall/skills-pack/antigravity/`
- Acessiveis via permissao no build.md (leitura direta)

### Skills Pack Codex (~1054 skills)
- Path: `vibecoderconfigall/skills-pack/codex/`
- Acessiveis via permissao no build.md (leitura direta)

### Regra de Auto-Escaneamento
O agente build tem instrucao permanente para:
1. Classificar o dominio da tarefa ao recebe-la
2. Escanear proativamente `glob **/SKILL.md` nos diretorios acima
3. Usar `grep` para encontrar skills pelo nome/descricao do dominio
4. Ler o SKILL.md das skills mais relevantes e aplicar as instrucoes
5. Skills registradas via `skill load` tem prioridade maxima

### Diretorios de skills acessiveis (configurados no build.md):
- `C:\Users\pedro\.agents\skills\*`
- `C:\Users\pedro\.claude\skills\*`
- `C:\.agents\skills\*`
- `C:\.claude\skills\*`
- `C:\Users\pedro\OneDrive\...\skills-pack\antigravity\*`
- `C:\Users\pedro\OneDrive\...\skills-pack\codex\*`
- `C:\Users\pedro\OneDrive\...\vibecoderconfigall\skills\*`

---

## 6. Pack Obrigatório de 10 Skills

Todo agente/IDE deve iniciar qualquer atuação carregando o pack obrigatório de 10 skills antes de qualquer outra ação.

### Pack Obligatório:
1. **caveman** — Clareza, objetividade, economia de tokens, evitar enrolação
2. **lyvox-core-reader** — Leitura obrigatória do Lyvox Core, MOCs, registries, source-authority, review queue
3. **audit-context-building** — Entender contexto real antes de atuar
4. **deep-research** — Pesquisa profunda quando houver lacuna ou tema externo
5. **concise-planning** — Planejar antes de executar, com fases, riscos e validações
6. **subagent-driven-development** — Ativar subagentes especializados em tarefas complexas
7. **architecture-skill** — Decisões técnicas, estrutura, sistemas, escalabilidade
8. **security-skill** — Segredos, dados sensíveis, permissões, RLS/RBAC
9. **multiagent-qa-orchestration** — QA final, validação cruzada, revisão multiagente
10. **documentation** — Documentação final, changelog, relatórios, rastreabilidade

### Regra:
> Todo agente/IDE deve iniciar qualquer atuação carregando o pack obrigatório de 10 skills. Depois disso, pode ativar skills adicionais conforme o contexto.

### Vault Canônico:
O Lyvox Core (`D:\Lyvox Core\Lyvox Core`) é o vault principal. Referências antigas a vaults antigos foram corrigidas.

---

## 7. Operação Lyvox em VPS e n8n

- **Fonte e autoridade:** `D:\Lyvox Core\Lyvox Core` é a fonte documental canônica. Código, runtime, migrations, manifests e testes atuais prevalecem quando houver divergência operacional. `Rockscore` não é alias confirmado e não deve motivar renomeações.
- **Documentação sanitizada:** publicar somente itens `public` ou `internal` presentes em allowlist, após scan e revisão humana. Bloquear conteúdo `restricted`, `confidential`, `secret`, sem classificação, PII e dados de clientes, bancários ou societários.
- **Runtime:** a VPS Ubuntu e o Docker hospedam a execução; o n8n orquestra eventos e integrações. O Telegram é console futuro, nunca shell arbitrário.
- **Autenticação n8n:** Basic Auth foi removido desde o n8n 1.0. Usar owner account nativo, `N8N_ENCRYPTION_KEY` persistente, acesso por localhost/reverse proxy HTTPS e 2FA quando disponível.
- **Aprovação:** ações externas, destrutivas, de produção ou que alterem dados/permissões exigem aprovação humana explícita. Ausência de resposta significa negar.
- **Delegação e QA:** subagentes recebem escopo e menor privilégio. Toda entrega relevante inclui QA real, scan de secrets e relatório de execução; validações não executadas devem ser declaradas.
