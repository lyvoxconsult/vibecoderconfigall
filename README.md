# vibecoderconfigall

Kit versionado para reconstruir o ambiente técnico da Lyvox e provisionar uma VPS Ubuntu com Docker, n8n, agentes, prompts, skills e documentação sanitizada. Contém apenas configuração reutilizável e templates; não contém código comercial, bancos, credenciais ou documentos restritos.

## Capacidades

- Bootstrap idempotente para Ubuntu/Debian em `bootstrap.sh`.
- Instalação modular de ferramentas, Docker Engine e Docker Compose.
- n8n em container, com persistência, healthcheck e bind local por padrão.
- Backup, restore, atualização, status e validação operacional.
- Sincronização segura de skills por allowlist e manifest.
- Sincronização documental do Lyvox Core por allowlist, dry-run e bloqueio por sensibilidade.
- Agentes, prompts e templates para futuras automações Lyvox.
- Suporte legado para reconstrução do ambiente Windows.

## Limites de segurança

- Nunca copie `.env`, bancos, dumps, logs, credenciais, cookies, JWTs, tokens ou chaves privadas.
- Use somente arquivos `*.example` e placeholders.
- O Lyvox Core original é somente leitura. Este repositório não o modifica.
- `Rockscore` não foi confirmado como alias de Lyvox Core; não normalize o nome sem decisão humana.
- O Gerenciamento e sistemas externos ficam fora do escopo.

Detalhes: [SECURITY_NOTES.md](SECURITY_NOTES.md).

## VPS Ubuntu

Requisitos: Ubuntu 22.04/24.04 ou Debian compatível, usuário com `sudo`, Git e internet.

```bash
sudo apt update
sudo apt install -y git curl
git clone https://github.com/SEU_USUARIO/vibecoderconfigall.git
cd vibecoderconfigall
chmod +x bootstrap.sh installers/linux/*.sh scripts/*.sh skills/*.sh
./bootstrap.sh
```

O bootstrap cria a estrutura sob `LYVOX_ROOT` (padrão `/opt/lyvox`), instala Docker pelo repositório oficial, prepara skills/docs, cria `/opt/lyvox/n8n/.env` com chave aleatória segura e sobe n8n. Para revisar antes de iniciar: `START_N8N=0 ./bootstrap.sh`, edite `/opt/lyvox/n8n/.env` e execute `installers/linux/install-n8n.sh`.

Não use `curl | bash` sem revisar e fixar uma revisão. Clone e inspecione o código antes da execução privilegiada.

## n8n

Para operar diretamente pelo clone, sem instalar em `/opt`:

```bash
cp docker/n8n/.env.example docker/n8n/.env
editor docker/n8n/.env
docker compose --env-file docker/n8n/.env -f docker/n8n/docker-compose.yml config
docker compose --env-file docker/n8n/.env -f docker/n8n/docker-compose.yml up -d
./scripts/healthcheck.sh
```

A porta é ligada a `127.0.0.1` por padrão. n8n atual exige conta owner no primeiro acesso; `N8N_BASIC_AUTH_*` foi removido no n8n 1.0 e não é usado. Para internet pública, configure domínio, HTTPS e proxy reverso antes de alterar o bind.

## Operação

```bash
./scripts/print-status.sh
./scripts/validate-environment.sh
./scripts/check-secrets.sh
sudo ./scripts/backup-n8n.sh
sudo ./scripts/restore-n8n.sh --help
./scripts/update-skills.sh --source "$HOME/.codex/skills" # dry-run
./scripts/sync-lyvox-core-sanitized.sh --source /caminho/do/core --allowlist docs/lyvox-core-allowlist.txt
```

Consulte [QUICK_START.md](QUICK_START.md), [n8n/README.md](n8n/README.md) e [docs/backup-restore.md](docs/backup-restore.md).

## Estrutura

```text
bootstrap.sh             orquestrador VPS
installers/linux/        módulos idempotentes
docker/n8n/              runtime canônico do n8n
n8n/                     operação, workflows e credenciais
scripts/                 validação, backup, restore, sync e status
skills/                  catálogo, manifest e instaladores
agents/                  regras, prompts, subagentes e templates
docs/                    arquitetura, segurança e governança
obsidian/                blueprint documental sanitizado
reports/                 implementação, QA e segurança
```

## Windows

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
.\installers\windows\install.ps1
.\installers\windows\validate.ps1
.\scripts\check-secrets.ps1
```

## Fonte de verdade

O Lyvox Core canônico é `D:\Lyvox Core\Lyvox Core`. Código, manifests, migrations, testes e runtime atual prevalecem quando houver divergência. Conteúdo do Core entra aqui somente por snapshot sanitizado e rastreável.

## Validação

```bash
bash -n bootstrap.sh installers/linux/*.sh scripts/*.sh skills/*.sh
./scripts/validate-repo.sh
./scripts/check-secrets.sh
docker compose --env-file docker/n8n/.env.example -f docker/n8n/docker-compose.yml config
```

Aplicações de skills e Core exigem arquivo de aprovação vinculado ao hash exibido no dry-run. Exemplos: `skills/skills-approval.example` e `docs/lyvox-core-approval.example`.

Resultados e limitações: `reports/VALIDATION_REPORT.md` e `reports/SECURITY_SCAN_REPORT.md`.
