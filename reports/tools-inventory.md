# 🧰 Inventário de Ferramentas e Tecnologias

> **Repositório:** vibecoderconfigall
> **Atualizado em:** 2026-05-26

---

## Ferramentas de Desenvolvimento

| Ferramenta | Uso Principal | Script de Instalação |
|---|---|---|
| **Git** | Controle de versão | `install-tools` |
| **Node.js** (LTS) | Runtime JavaScript | `install-node` |
| **npm** | Gerenciador de pacotes Node | Incluído no Node |
| **pnpm** | Gerenciador de pacotes (rápido) | `install-node` |
| **FNM** (Windows) | Gerenciador de versões Node | `install-node.ps1` |
| **nvm** (Linux) | Gerenciador de versões Node | `install-node.sh` |
| **Python 3** | Scripts e automação | `install-python` |
| **uv** (Astral) | Gerenciador de pacotes Python | `install-python` |
| **Docker Desktop** | Containers | `install-tools` |
| **Supabase CLI** | Backend as a Service | `install-tools` |

---

## Editores e IDEs

| Ferramenta | Uso | Configuração |
|---|---|---|
| **VS Code** | Editor principal | `configs/vscode/settings.json` |
| **Antigravity** | IDE com IA integrada | `agents/antigravity-global-prompt.md` |

---

## Agentes de IA

| Agente | Configuração | MCP Config |
|---|---|---|
| **Antigravity** | `agents/antigravity-global-prompt.md` | `mcp/mcp-config.example.json` |
| **Codex** | `agents/codex-global-prompt.md` | `mcp/codex-mcp-config.example.toml` |

---

## Segundo Cérebro

| Ferramenta | Localização | Documentação |
|---|---|---|
| **Obsidian** | `D:\Obsidian\obsidian` | `docs/obsidian-structure.md` |

---

## Extensões do VS Code (Categorias)

| Categoria | Exemplos |
|---|---|
| **IA & Copilots** | GitHub Copilot, Codeium, Supermaven |
| **Linguagens** | ESLint, Prettier, Python, Pylance |
| **Frontend** | Tailwind IntelliSense, CSS Peek, Auto Rename Tag |
| **Backend** | REST Client, Docker, Database Client |
| **Git** | GitLens, Git Graph |
| **Produtividade** | Todo Tree, Bookmarks, Path IntelliSense |
| **Temas** | One Dark Pro, Material Icon Theme |

> Lista completa nos scripts `install-extensions.ps1` / `install-extensions.sh`.
