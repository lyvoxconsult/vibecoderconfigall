# 🧠 Skills Pack — Backup Completo

> **Gerado em:** 2026-05-26
> **Escopo:** Backup integral de todas as skills do Antigravity e Codex

---

## Estrutura

```
skills-pack/
├── antigravity/     # 1.425 skills do Antigravity IDE
│   ├── <skill-name>/
│   │   ├── SKILL.md          # Instruções principais
│   │   ├── scripts/          # Scripts auxiliares (quando existem)
│   │   ├── examples/         # Exemplos de uso
│   │   ├── resources/        # Recursos adicionais
│   │   └── references/       # Documentação de referência
│   └── ...
│
└── codex/           # 1.053 skills do Codex CLI
    ├── <skill-name>/
    │   ├── SKILL.md
    │   └── ...
    └── ...
```

## Totais

| Fonte | Skills |
|---|---|
| **Antigravity** | 1.425 |
| **Codex** | 1.053 |
| **Total** | **2.478** |

---

## Como Usar

### Restaurar skills no Antigravity
```powershell
# Windows
robocopy "skills-pack\antigravity" "$env:USERPROFILE\.gemini\config\skills" /E

# Linux
cp -r skills-pack/antigravity/* ~/.gemini/config/skills/
```

### Restaurar skills no Codex
```powershell
# Windows
robocopy "skills-pack\codex" "$env:USERPROFILE\.codex\skills" /E

# Linux
cp -r skills-pack/codex/* ~/.codex/skills/
```

---

## Notas de Segurança

- As skills são **arquivos de instrução** (markdown, scripts de referência), não contêm dados sensíveis por padrão.
- Mesmo assim, o script `check-secrets` faz varredura no diretório completo antes de cada commit.
- Se alguma skill customizada contiver tokens, remova ou substitua por placeholders antes de versionar.

---

## Manutenção

Para atualizar o backup com novas skills adquiridas:

```powershell
# Antigravity
robocopy "$env:USERPROFILE\.gemini\config\skills" "skills-pack\antigravity" /E /XO

# Codex
robocopy "$env:USERPROFILE\.codex\skills" "skills-pack\codex" /E /XO
```

O flag `/XO` ignora arquivos que já estão atualizados, copiando apenas novos ou modificados.
