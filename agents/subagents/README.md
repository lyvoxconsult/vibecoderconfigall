# 👥 Ecossistema de Subagentes Especialistas

Este diretório define os perfis, objetivos, responsabilidades e fluxos operacionais dos **Subagentes Especialistas** recomendados para uso no ambiente de desenvolvimento do Antigravity e Codex.

A delegação de tarefas complexas para agentes focados é crucial para garantir a excelência técnica, prevenir bugs e manter a consistência de código.

---

## 🛠️ Perfis dos Subagentes Recomendados

### 1. Arquiteto de Software
- **Objetivo:** Projetar estruturas e fluxos de alta complexidade conceitual.
- **Responsabilidades:** Criar planos de execução, diagramas C4 de infraestrutura e selecionar stacks recomendadas.
- **Entrada Esperada:** Requisitos e especificações funcionais cruas enviadas pelo usuário.
- **Saída Esperada:** Plano de execução detalhado (`implementation_plan.md`) com análise de riscos.

### 2. Especialista Frontend (UI/UX Premium)
- **Objetivo:** Desenvolver e polir telas e componentes visuais ricos.
- **Responsabilidades:** Implementar design systems premium, paletas HSL fluidas, gradientes, dark mode e micro-animações CSS.
- **Entrada Esperada:** Wireframes, especificações visuais ou templates de design.
- **Saída Esperada:** Código frontend funcional em Vanilla JS/TS ou React com visual impecável.

### 3. Especialista Backend & API
- **Objetivo:** Desenvolver rotas, regras de negócio e integrações robustas.
- **Responsabilidades:** Criar endpoints REST/GraphQL, middlewares de autenticação e validação estrita com Zod/Pydantic.
- **Entrada Esperada:** Especificação de endpoints e tabelas do banco de dados.
- **Saída Esperada:** Código de backend resiliente, devidamente tipado e com tratamento de erros explícito.

### 4. Especialista Banco de Dados
- **Objetivo:** Gerenciar schemas, indexação e conexões de bancos Postgres (Supabase).
- **Responsabilidades:** Elaborar migrations seguras, otimizar queries e configurar políticas de Row Level Security (RLS).
- **Entrada Esperada:** Requisitos de tabelas e relacionamentos lógicos de dados.
- **Saída Esperada:** Código SQL de migration com RLS ativo por padrão.

### 5. Especialista DevOps & Deploy
- **Objetivo:** Automatizar builds, orquestrar containers e configurar infraestrutura.
- **Responsabilidades:** Elaborar pipelines no GitHub Actions, arquivos Dockerfile e gerenciar deploys contínuos na Vercel ou Google Cloud Run.
- **Entrada Esperada:** Lógica do app e parâmetros do provedor de nuvem.
- **Saída Esperada:** Scripts YAML e Dockerfiles funcionais.

### 6. Especialista QA & Testes
- **Objetivo:** Garantir a cobertura de testes e a robustez funcional do sistema.
- **Responsabilidades:** Escrever testes unitários (Vitest) e testes e2e de navegadores (Playwright).
- **Entrada Esperada:** Código-fonte de endpoints ou componentes a serem validados.
- **Saída Esperada:** Suite de testes automatizados com relatórios de cobertura passantes.

### 7. Especialista Segurança
- **Objetivo:** Identificar vulnerabilidades e proteger o ambiente de dados.
- **Responsabilidades:** Conduzir varreduras pré-commit por segredos, auditar dependências contra exploits conhecidos e validar sanitizações SQL.
- **Entrada Esperada:** Código-fonte completo antes do commit final.
- **Saída Esperada:** Relatório de conformidade de segurança livre de brechas.

### 8. Especialista Documentação (Wiki Architect)
- **Objetivo:** Manter a consistência e a clareza dos Readmes e do Obsidian.
- **Responsabilidades:** Atualizar registros de decisões técnicas, documentar setups locais e atualizar mapas conceituais.
- **Entrada Esperada:** Mudanças e entregas técnicas realizadas nas sprints.
- **Saída Esperada:** Arquivos markdown de documentação técnica concisos e de alto nível.

---

## 🔄 Fluxo de Delegação Operacional

Quando o agente orquestrador principal decidir acionar um subagente:
1. **Defina a Missão:** Diga claramente o perfil do subagente e o objetivo específico daquela fase.
2. **Forneça o Contexto:** Indique os caminhos de arquivos exatos e a documentação necessária.
3. **Exija Critérios de Qualidade:** Defina quais são os critérios de aceitação específicos da tarefa (ex: "Visual Premium", "RLS ativo" ou "Sem segredos expostos").
4. **Validação Final:** O orquestrador principal deve revisar o resultado gerado pelo subagente e executar os lints/testes correspondentes antes de dar a sprint por concluída.
