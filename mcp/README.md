# Model Context Protocol (MCP) no vibecoderconfigall

O **Model Context Protocol (MCP)** é um padrão aberto desenvolvido pela Anthropic para permitir que agentes de IA e IDEs (como Antigravity, Cursor, Codex e VS Code) conectem-se de forma segura a fontes de dados locais ou remotas e ferramentas externas (APIs, bancos de dados, navegadores).

Esta pasta contém configurações de exemplo e roteiros para provisionar rapidamente servidores MCP de interesse no seu ambiente de desenvolvimento.

---

## 🛠️ Servidores MCP Habilitados por Padrão no Ambiente

Com base na varredura do seu ambiente operacional principal, os seguintes servidores de contexto estão integrados:

1. **Cloud Run (`cloudrun`):**
   - **Objetivo:** Orquestrar e interagir diretamente com serviços na Google Cloud Run de forma automatizada pelos agentes.
   - **Comando:** `npx -y @google-cloud/cloud-run-mcp`

2. **Supabase MCP (`supabase`):**
   - **Objetivo:** Manipular instâncias de Supabase, realizar queries rápidas e gerenciar bancos Postgres em ambiente de teste ou cloud.
   - **Conectado via:** Servidor remoto HTTPS (`https://mcp.supabase.com/mcp`)

3. **StitchMCP (`StitchMCP`):**
   - **Objetivo:** Fornecer aos agentes de IA capacidade avançada de criação e modificação de layouts interativos de UI, componentes e design systems utilizando o ecossistema do Stitch.
   - **Parâmetros:** Conectado via bridge CLI com autenticação via header seguro API Key.

4. **GitHub MCP Server (`github-mcp-server`):**
   - **Objetivo:** Dar autonomia para os agentes listarem issues, gerarem pull requests, revisarem alterações de código e comentarem em fluxos de CI/CD diretamente.
   - **Estrutura:** Executado via container Docker local isolado, consumindo o token do GitHub.

---

## 🔐 Como Injetar suas Credenciais nos Servidores MCP

Por motivos de segurança obrigatória, chaves reais e tokens foram substituídos por placeholders nos arquivos de template. Para reativar os servidores na nova máquina:

1. Abra o arquivo de configuração da sua IDE ou do Antigravity (normalmente em `~/.gemini/config/mcp_config.json` ou nas configurações do Cursor).
2. Configure as variáveis conforme o arquivo [mcp-config.example.json](file:///C:/Users/pedro/OneDrive/Documentos/00-Projetos/vibecoderconfigall/mcp/mcp-config.example.json).
3. Substitua `INSIRA_SUA_CHAVE_STITCH_AQUI` e `INSIRA_SEU_GITHUB_PAT_AQUI` por chaves geradas em seus respectivos painéis de desenvolvedor.

---

## 🚀 Instalando Novos Servidores MCP
Você pode expandir a lista de MCPs adicionando novos comandos sob a chave `"mcpServers"` nas configurações. Recomenda-se usar `npx` (para pacotes Node.js) ou containers `docker` isolados para garantir a segurança e a portabilidade do seu ambiente operacional.
