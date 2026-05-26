# 📋 Template: Base de Conhecimento de Projeto Comercial (Obsidian)

Copie este template para iniciar a documentação de qualquer novo projeto comercial dentro da pasta `10 - Projetos/NomeDoProjeto/00 - Visão Geral.md` do seu Obsidian.

---

```markdown
# 🪐 [Nome do Projeto] — Visão Geral

> Descrição de uma frase sobre o produto/sistema e o problema real de negócios que ele resolve.

---

## 👥 Informações Gerais
- **Cliente:** [Nome do Cliente ou Lyvox]
- **Status:** [Em Planejamento / Em Execução / Em Manutenção / Finalizado]
- **Repositório Git:** [Link do Repositório]
- **URL de Produção:** [Link do Site/App Publicado]
- **Ambiente de Homologação:** [Link de Staging/Teste]

---

## 🏗️ Arquitetura e Stack Tecnológica
Descreva resumidamente a arquitetura e as ferramentas utilizadas no sistema:

- **Frontend:** [React + Vite / Next.js / HTML5 + Vanilla JS]
- **Estilização:** [Tailwind CSS / Vanilla CSS / Design Tokens]
- **Backend/API:** [Node.js / Express / Next.js API Routes / Python FastAPI]
- **Banco de Dados / Serverless:** [Supabase Postgres / Neon DB / Local SQLite]
- **Autenticação:** [Supabase Auth / Clerk / NextAuth]
- **Hospedagem & Infraestrutura:** [Vercel / Netlify / Docker Desktop / Cloud Run]

---

## ⚙️ Variáveis de Ambiente Necessárias (.env)
*Nota: NUNCA digite chaves reais ou secrets confidenciais de produção aqui. Apenas as chaves requeridas para rodar o projeto localmente.*

```env
GEMINI_API_KEY=sua_chave_local
SUPABASE_URL=sua_url_supabase
SUPABASE_ANON_KEY=sua_anon_key
DATABASE_URL=sua_string_conexao_postgresql
```

---

## 📁 Instruções de Setup Local
Passos mínimos para rodar o projeto do zero em um novo computador:

1. Clonar o repositório:
   `git clone [link-repo]`
2. Instalar dependências:
   `pnpm install` ou `npm install`
3. Provisionar o arquivo de variáveis:
   Copiar `.env.example` para `.env` e preencher.
4. Iniciar o servidor de desenvolvimento:
   `pnpm dev` ou `npm run dev`

---

## 📌 Links Importantes e Documentações Auxiliares
- [Layout no Figma](url-figma)
- [Documentação da API no Swagger](url-swagger)
- [Manual Operacional do Cliente](link-para-nota-interna-ou-pdf)
```

---

## 📝 Template: Registro de Decisões Técnicas (`Decisões Técnicas.md`)

Use esta estrutura para manter um histórico conciso e fácil de ler de todas as alterações arquiteturais significativas no seu projeto:

```markdown
# 🛠️ Registro de Decisões Técnicas — [Nome do Projeto]

## [DD-MM-YYYY] - Título da Decisão / Refatoração

### Contexto e Problema
- O que estava quebrado, lento ou limitando o desenvolvimento? Qual era o problema original?

### Solução Proposta e Implementada
- O que foi construído ou alterado? Qual biblioteca foi adicionada ou lógica foi modificada?

### Justificativa Técnica
- Por que essa abordagem é superior às alternativas? (Ex: melhor legibilidade, performance de carregamento, menor custo de servidor, facilidade de manutenção futura).

### Efeitos Colaterais e Limitações
- Existe algum ponto de atenção? Há algum gargalo ou comportamento que outros desenvolvedores devem saber ao mexer nessa área?
```
