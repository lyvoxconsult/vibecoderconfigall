# 🧠 Blueprint: Estrutura Organizacional do Second Brain no Obsidian

Este arquivo serve como guia de arquitetura e blueprint estrutural para configurar um **Cérebro Digital** (Second Brain) voltado a engenheiros de software que trabalham intensamente com IAs (Codex, Antigravity).

---

## 📂 Diretórios Operacionais Recomendados

Para estruturar o seu Obsidian de forma ideal para o seu fluxo de desenvolvimento, crie as seguintes pastas:

### 1. `00 - Inbox`
- **Finalidade:** Captura rápida de ideias, links, pensamentos rápidos, tarefas urgentes e anotações cruas feitas no celular ou na correria do dia a dia. Tudo cai aqui primeiro para posterior classificação.

### 2. `10 - Projetos`
- **Finalidade:** Notas ativas de projetos que você está executando ativamente (ex: `Gerenciamento`, `CacambasGoOficial`). Cada projeto deve ter uma pasta dedicada.
- **Notas obrigatórias por projeto:**
  - `00 - Visão Geral.md` (Escopo e links)
  - `Tarefas e Sprints.md` (Controle de TODO)
  - `Decisões Técnicas.md` (Logs de mudanças arquiteturais)

### 3. `20 - Áreas`
- **Finalidade:** Responsabilidades contínuas e de longo prazo que não têm um prazo final definitivo (ex: `Saúde`, `Gestão Financeira`, `Markting`, `Carreira`, `Segurança Digital`).

### 4. `30 - Recursos`
- **Finalidade:** Sua biblioteca de referências e conhecimentos de interesse geral (ex: `Cheat sheets de Git`, `Tutoriais de Docker`, `Aulas de CSS Grid`, `Modelos de prompts`, `Snippets de código-fonte reutilizáveis`).

### 5. `40 - Arquivo`
- **Finalidade:** Notas frias, inativas ou projetos finalizados que você não está mais atuando, mas que deseja guardar para consulta ou referência técnica futura.

---

## 🔗 Sistema de Links e Simbiose de Agentes (Codex/Antigravity)

1. **Backlinks para Rastreamento:** Sempre use `[[Nome da Nota]]` para conectar conceitos. Por exemplo, na nota de `CacambasGoOficial/Decisões Técnicas.md`, crie um link apontando para `[[Supabase]]` na pasta de Recursos.
2. **Contexto Imediato:** Quando você pede para o Antigravity criar um novo componente ou arrumar uma API, forneça a ele o caminho absoluto da nota de contexto no Obsidian.
   - **Exemplo de instrução:** *"Consulte o arquivo de visão geral do projeto em `D:/Obsidian/obsidian/Projetos/Gerenciamento/00 - Visão Geral.md` para entender as dependências antes de começar."*
3. **Log Técnico Automatizado:** Ao finalizar a tarefa, ordene: *"Escreva um resumo executivo desta refatoração diretamente no arquivo de decisões técnicas do projeto no Obsidian"*. Isso garante que o seu cérebro digital permaneça sempre atualizado sem esforço manual.
