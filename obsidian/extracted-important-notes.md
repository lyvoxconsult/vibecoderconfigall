# 📓 Notas Extraídas e Refinadas do Obsidian (Exemplo Seguro)

Este documento centraliza notas, aprendizados e referências úteis de engenharia extraídos e higienizados a partir da análise segura do cofre local `D:\Obsidian\obsidian`. Foram removidos quaisquer dados de clientes, chaves confidenciais ou segredos de negócio.

---

## 🛠️ Stack Operacional Recomendada

Com base nos registros analisados do cofre (`Mapa de Tecnologias.md` e históricos), a stack de desenvolvimento ideal e seus respectivos padrões arquiteturais recomendados para novos sistemas são:

### 1. Frontend & Interfaces
- **Visual Premium:** Layouts responsivos e fluidos com suporte nativo a dark mode por padrão.
- **Vanilla CSS + Variáveis HSL:** Preferência técnica por arquivos CSS modulares, limpos e estruturados de forma semântica, priorizando carregamento instantâneo.
- **Tipografia:** Uso da fonte **Inter** ou **Google Fonts** modernas para substituir fontes padrões dos navegadores.

### 2. Autenticação e Armazenamento (Supabase)
- **Segurança de Linha (RLS):** Toda e qualquer tabela criada nas instâncias de Postgres do Supabase deve possuir políticas de RLS (*Row Level Security*) ativas por padrão. Nunca permita leitura ou escrita anônima irrestrita.
- **Conexão Resiliente:** Integrações de backend devem usar gerenciamento de pool de conexões (via Prisma Accelerated ou Neon Serverless Drivers) para evitar estouro de conexões simultâneas do Postgres em funções serveless.

### 3. Automação e Qualidade
- **Testes Unitários:** Scripts e endpoints cruciais devem possuir cobertura de testes automatizados com frameworks leves e velozes como **Vitest** ou **Playwright** para fluxos e2e de navegadores.
- **Validação Estrita de Dados:** Interfaces de APIs devem usar schemas tipados (como Zod ou Pydantic) para garantir validações rigorosas antes de inserir dados nas tabelas ou disparar processos.

---

## 🧠 Integração Operacional com Agentes (Codex / Antigravity)

1. **Análise Antes de Agir:** As IAs de desenvolvimento não devem alterar o código-fonte de um arquivo sem antes analisar seu impacto global em dependências e efeitos colaterais.
2. **Uso Constante de Skills:** O diretório de `/skills/` do repositório deve ser visto pelas IAs como a sua biblioteca de métodos certificados. Criar soluções customizadas e gambiarras sem antes buscar conformidade nas skills é um comportamento a ser ativamente bloqueado.
3. **Logs de Sucesso Reais:** Sucesso verbalizado em conversas sem a validação técnica de compilação ou execução de testes é considerado uma falha operacional grave das IAs.
