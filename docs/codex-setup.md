# ⚙️ Configuração e Provisionamento do Codex

O **Codex** é a sua engine robusta para desenvolvimento focado em backend, pipelines pesadas de engenharia de dados, segurança de código e auditoria de sistemas. Este guia orienta a restaurar, configurar e utilizar o Codex com eficiência máxima.

---

## 📂 Arquivos de Configuração Relacionados

- [mcp/codex-mcp-config.example.toml](file:///C:/Users/pedro/OneDrive/Documentos/00-Projetos/vibecoderconfigall/mcp/codex-mcp-config.example.toml) (Estrutura segura de MCPs para Codex)
- [agents/codex-global-prompt.md](file:///C:/Users/pedro/OneDrive/Documentos/00-Projetos/vibecoderconfigall/agents/codex-global-prompt.md) (System prompt customizado para Codex)

---

## 🛠️ Passo a Passo de Restauração de Ambiente

Para provisionar o Codex em um novo computador:

1. **Instale as Dependências de Sistema:**
   Garanta que ferramentas de containerização e runtimes estejam presentes. Use:
   - No Windows: `.\installers\windows\install-tools.ps1`
   - No Linux: `./installers/linux/install-tools.sh`

2. **Injete o System Prompt e Regras:**
   Copie as regras globais e prompts customizados para a pasta de contexto padrão do Codex. O script de restore faz isso automaticamente:
   ```powershell
   .\scripts\restore-windows.ps1
   ```
   *Nota: O script copia o prompt global e as regras para o diretório de configurações operacionais do Codex local.*

3. **Configure os Servidores MCP:**
   Edite seu arquivo `codex-mcp-config.toml` preenchendo as chaves mascaradas de acordo com as instruções de [SECURITY_NOTES.md](file:///C:/Users/pedro/OneDrive/Documentos/00-Projetos/vibecoderconfigall/SECURITY_NOTES.md).

---

## 💡 Boas Práticas ao Utilizar o Codex

- **Foco em Conclusão Técnica:** O Codex é projetado para atuar como um engenheiro pleno/sênior de software. Evite diálogos desnecessários. Incentive-o a responder com blocos de códigos e testes acionáveis imediatos.
- **Delegação via Subagentes:** Sempre que uma tarefa backend envolver migrações de banco, queries complexas de Supabase e fluxos complexos de deploy, ordene que o Codex crie um plano de execução detalhado e utilize subagentes especializados para as entregas de cada módulo.
- **Consistência de Tipagem:** Ao trabalhar com TypeScript ou Python, exija que o Codex siga à risca padrões estritos de tipagem e utilize schemas de validação como Zod ou Pydantic para interações em endpoints de API.
- **Segurança de Código:** Nunca finalize uma tarefa de refatoração no Codex sem solicitar que a IA rode o skill preventivo de segurança para auditar vulnerabilidades clássicas como injeção SQL, CORS mal configurado ou vazamento de escopo de variáveis.
