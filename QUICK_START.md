# Quick Start

## 1. Clonar e preparar

```bash
sudo apt update && sudo apt install -y git curl
git clone https://github.com/SEU_USUARIO/vibecoderconfigall.git
cd vibecoderconfigall
chmod +x bootstrap.sh installers/linux/*.sh scripts/*.sh skills/*.sh
```

## 2. Executar bootstrap

```bash
./bootstrap.sh
```

O instalador cria `/opt/lyvox/n8n/.env` com `N8N_ENCRYPTION_KEY` aleatória e mantém bind em `127.0.0.1`.

Para revisar configuração antes de subir:

```bash
START_N8N=0 ./bootstrap.sh
sudo editor /opt/lyvox/n8n/.env
./installers/linux/install-n8n.sh
```

Raiz alternativa: `LYVOX_ROOT=/opt/lyvox ./bootstrap.sh`.

## 3. Subir ou verificar n8n

```bash
sudo docker compose --env-file /opt/lyvox/n8n/.env -f /opt/lyvox/n8n/docker-compose.yml up -d
./scripts/healthcheck.sh
./scripts/print-status.sh
```

Depois de sair e entrar novamente na sessão, o usuário adicionado ao grupo `docker` normalmente não precisa de `sudo`.

Túnel SSH:

```bash
ssh -L 5678:127.0.0.1:5678 usuario@IP_DA_VPS
```

Acesse `http://127.0.0.1:5678` e crie a conta owner. Basic Auth legado não é suportado pelo n8n atual.

## 4. QA e segurança

```bash
./scripts/validate-environment.sh
./scripts/validate-repo.sh
./scripts/check-secrets.sh
```

## 5. Backup, restore e sync

```bash
sudo ./scripts/backup-n8n.sh
sudo ./scripts/restore-n8n.sh --help
./scripts/update-skills.sh --source "$HOME/.codex/skills" # dry-run
./scripts/sync-lyvox-core-sanitized.sh --source /caminho/do/core --allowlist docs/lyvox-core-allowlist.txt
```

Teste restore separado. Para aplicar sync, use `--approval FILE --apply` somente depois de revisar o hash do dry-run. Nunca use Lyvox Core como destino.

## Windows

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
.\installers\windows\install.ps1
.\installers\windows\validate.ps1
```
