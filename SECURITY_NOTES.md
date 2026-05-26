# 🛡️ Notas de Segurança e Higienização (SECURITY_NOTES)

Este repositório foi construído seguindo a filosofia corporativa de **Zero Trust** e **Zero Leak**. Como este projeto se tornará um repositório Git, todo e qualquer dado secreto, chave de API ou credencial comercial deve ser rigorosamente impedido de ser persistido.

---

## 🚫 O que foi Sanitizado e Mascarado

Durante a varredura e preparação do ambiente, os seguintes dados foram identificados como altamente sensíveis e substituídos por placeholders no repositório:

1. **Tokens de Modelos de Linguagem:**
   - `OPENAI_API_KEY`, `GEMINI_API_KEY`, `ANTHROPIC_API_KEY`.
   - Substituídos nos templates por: `insira_sua_chave_aqui` ou placeholders similares.

2. **Acessos ao Cloud e Deploy:**
   - `VERCEL_TOKEN`, `GITHUB_TOKEN`, `NETLIFY_AUTH_TOKEN`.
   - Removidos completamente de todos os arquivos de configuração locais copiados.

3. **Conexões de Banco de Dados:**
   - Strings de conexão reais de PostgreSQL, MySQL e tokens de serviço Supabase (`SUPABASE_URL`, `SUPABASE_ANON_KEY`, `SUPABASE_SERVICE_ROLE_KEY`).
   - Substituídos por estruturas limpas de exemplo.

4. **Credenciais Locais e de Terminal:**
   - Senhas criptografadas em perfis do terminal ou scripts privados do PowerShell.
   - Qualquer variável de PATH que exponha pastas privadas não padronizadas.

---

## 📁 Arquivos Bloqueados (.gitignore Ativo)

O arquivo `.gitignore` global do repositório foi configurado de forma a evitar o envio acidental de arquivos locais que contenham segredos. Dentre eles:

- Qualquer arquivo com extensão `.env`, `.env.local`, `.env.development.local`, `.env.production.local`, etc.
- Chaves SSH privadas e públicas (`id_rsa`, `id_ed25519`).
- Pastas temporárias de sessão (`.npm/`, `.cache/`, `.sass-cache/`).
- Dumps e logs locais de depuração contendo dados corporativos de projetos comerciais.
- Dados de banco de dados locais `.db`, `.sqlite`, `.sql`.

---

## 🛠️ Variáveis que Precisam ser Preenchidas Manualmente

Caso você restaure este ambiente em uma nova máquina, os seguintes itens deverão ser gerados e preenchidos no arquivo local `.env` (que nunca deve ser enviado ao Git):

```env
# Chaves de IA
GEMINI_API_KEY=sua_gemini_api_key_real
OPENAI_API_KEY=sua_openai_api_key_real
ANTHROPIC_API_KEY=sua_anthropic_api_key_real

# GitHub e Deploy
GITHUB_TOKEN=seu_github_personal_access_token
VERCEL_TOKEN=seu_vercel_deployment_token

# Supabase Local ou Cloud (Se usado em novos projetos base)
SUPABASE_URL=https://seu-projeto.supabase.co
SUPABASE_ANON_KEY=sua-anon-key-real
SUPABASE_SERVICE_ROLE_KEY=sua-service-role-key-real
```

---

## 🔍 Como Rodar a Auditoria Local de Segredos

Antes de subir qualquer commit para o GitHub, utilize o script automatizado de varredura incluído no repositório. Ele busca recursivamente por strings que contenham assinaturas típicas de segredos (chaves de API, senhas explícitas, strings de conexão).

### Comando PowerShell:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
.\scripts\check-secrets.ps1
```

### Comando Bash:
```bash
./scripts/check-secrets.sh
```

> [!WARNING]
> Nunca use a flag `--force` no git para forçar o envio de arquivos que o `.gitignore` está ignorando por padrão, a menos que você tenha absoluta certeza de que não há dados confidenciais contidos. A segurança técnica do seu ambiente de trabalho depende da disciplina operacional ao gerenciar chaves.
