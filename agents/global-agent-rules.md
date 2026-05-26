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
