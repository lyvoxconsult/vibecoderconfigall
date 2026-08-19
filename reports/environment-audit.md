# Auditoria histórica do ambiente — não usar como evidência atual

> Registro anterior preservado. Consulte os relatórios em caixa alta para o estado de 2026-07-12.

> **Gerado em:** 2026-05-26
> **Autor:** Agente Antigravity (automação)
> **Escopo:** Diagnóstico completo do ambiente de desenvolvimento

---

## 1. Ferramentas Instaladas (Esperadas)

| Ferramenta | Versão Esperada | Plataforma | Status |
|---|---|---|---|
| Git | >= 2.40 | Windows + Linux | ✅ Presente |
| Node.js | >= 20 LTS | Windows + Linux | ✅ Presente |
| npm | >= 10 | Windows + Linux | ✅ Presente |
| pnpm | >= 9 | Windows + Linux | ✅ Presente |
| Python 3 | >= 3.11 | Windows + Linux | ✅ Presente |
| uv (astral) | latest | Windows + Linux | ✅ Presente |
| Docker Desktop | latest | Windows | ✅ Presente |
| Supabase CLI | latest | Windows + Linux | 🔶 Opcional |
| FNM (Windows) | latest | Windows | ✅ Presente |
| nvm (Linux) | latest | Linux | ✅ Presente |

---

## 2. Extensões do VS Code

As extensões estão catalogadas em:
- [`installers/windows/install-extensions.ps1`](../installers/windows/install-extensions.ps1)
- [`installers/linux/install-extensions.sh`](../installers/linux/install-extensions.sh)

**Total de extensões catalogadas:** ~30+

---

## 3. Configurações de Agentes IA

| Agente | Prompt Global | MCP Config | Status |
|---|---|---|---|
| Antigravity | `agents/antigravity-global-prompt.md` | `mcp/mcp-config.example.json` | ✅ |
| Codex | `agents/codex-global-prompt.md` | `mcp/codex-mcp-config.example.toml` | ✅ |

---

## 4. Segurança e Conformidade

| Verificação | Status |
|---|---|
| `.gitignore` bloqueia `.env`, tokens, chaves | ✅ |
| `.env.example` contém apenas placeholders | ✅ |
| Scripts de `check-secrets` disponíveis (Win/Linux) | ✅ |
| Nenhum código-fonte de projetos copiado | ✅ |
| Nenhuma API key real no repositório | ✅ |
| `SECURITY_NOTES.md` documenta regras | ✅ |

---

## 5. Cobertura de Plataformas

| Componente | Windows (PS1) | Linux (Bash) |
|---|---|---|
| Instalador principal | ✅ `install.ps1` | ✅ `install.sh` |
| Ferramentas base | ✅ `install-tools.ps1` | ✅ `install-tools.sh` |
| Node.js | ✅ `install-node.ps1` | ✅ `install-node.sh` |
| Python | ✅ `install-python.ps1` | ✅ `install-python.sh` |
| Extensões VS Code | ✅ `install-extensions.ps1` | ✅ `install-extensions.sh` |
| Git | ✅ `configure-git.ps1` | ✅ `configure-git.sh` |
| Antigravity | ✅ `configure-antigravity.ps1` | ✅ `configure-antigravity.sh` |
| Codex | ✅ `configure-codex.ps1` | ✅ `configure-codex.sh` |
| Validação | ✅ `validate.ps1` | ✅ `validate.sh` |

---

## 6. Conclusão

O ambiente está **100% mapeado e replicável**. Todos os scripts de instalação cobrem ambas as plataformas. A conformidade de segurança foi validada: nenhum dado sensível está presente no repositório.
