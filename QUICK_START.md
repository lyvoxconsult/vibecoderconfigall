# Quick Start MacBook

## 1. Clonar

```bash
git clone https://github.com/SEU_USUARIO/vibecoderconfigall.git
cd vibecoderconfigall
```

## 2. Validar o pacote

Preferencialmente com PowerShell 7:

```bash
pwsh ./scripts/validate-repo.ps1
pwsh ./scripts/check-secrets.ps1
```

Fallback em Bash:

```bash
bash ./scripts/validate-repo.sh
bash ./scripts/check-secrets.sh
```

## 3. Entregar o prompt ao agente do Mac

Use o arquivo abaixo como instrucao principal:

```text
agents/macbook-bootstrap-prompt.md
```

Ele orienta o agente a:

- descobrir os caminhos reais do macOS antes de copiar arquivos;
- configurar Codex, Antigravity, MCPs, prompts e skills;
- preservar segredos fora do Git;
- usar Obsidian como fonte de contexto sem caminho fixo;
- validar instalacao com comandos reais;
- registrar pendencias sem simular sucesso.

## 4. Configurar variaveis locais

```bash
cp .env.example .env
```

Preencha somente no Mac local. Nao commite `.env`.

## 5. Ordem recomendada para o agente

1. Auditar ferramentas existentes no Mac: Git, Node, pnpm, Python, uv, Homebrew, VS Code, Codex, Antigravity e Obsidian.
2. Ler `agents/global-agent-rules.md`, `agents/codex-global-prompt.md` e `agents/antigravity-global-prompt.md`.
3. Revisar `skills obrigatorias/README.md` e `skills obrigatorias/skills-manifest.json`.
4. Copiar somente skills aprovadas para os destinos locais reais.
5. Aplicar exemplos em `configs/` trocando placeholders por caminhos descobertos no Mac.
6. Rodar validadores e reportar o que foi aplicado, ignorado e pendente.

## 6. Criterio de pronto

O setup so deve ser considerado pronto quando houver evidencia de:

- repo validado;
- secrets ausentes dos arquivos versionados;
- prompts globais instalados no destino correto;
- skills obrigatorias copiadas ou justificadamente pendentes;
- MCPs configurados com placeholders seguros ou credenciais locais fora do Git;
- Obsidian referenciado por caminho local confirmado no Mac;
- limitacoes documentadas.
