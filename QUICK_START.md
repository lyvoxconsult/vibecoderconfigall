# Guia de Início Rápido (QUICK_START)

Este guia prático fornece os comandos diretos e imediatos para você clonar, instalar, configurar e validar o seu ambiente utilizando o **vibecoderconfigall**.

---

## 💻 Configuração Automática no Windows

Abra o **PowerShell** (com privilégios de Administrador, caso queira instalar softwares de sistema via Winget) e execute a sequência abaixo de forma sequencial:

```powershell
# 1. Navegue até o repositório ou clone-o
cd C:\Users\pedro\OneDrive\Documentos\00-Projetos\vibecoderconfigall

# 2. Desbloqueie temporariamente a política de execução de scripts locais
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# 3. Execute o instalador de orquestração do ambiente
.\installers\windows\install.ps1

# 4. Valide a conformidade e integridade da instalação
.\installers\windows\validate.ps1
```

---

## 🐧 Configuração Automática no Linux (ou WSL)

Abra o seu terminal **Bash** (Ubuntu/Debian) e execute a sequência abaixo de forma sequencial:

```bash
# 1. Navegue até o repositório ou clone-o
cd ~/00-Projetos/vibecoderconfigall

# 2. Dê permissão de execução aos instaladores shell
chmod +x installers/linux/*.sh scripts/*.sh

# 3. Execute o script instalador principal
./installers/linux/install.sh

# 4. Valide a conformidade da instalação
./installers/linux/validate.sh
```

---

## 🔄 Fluxo de Atualização Contínua (Backup)

Sempre que fizer alterações relevantes no seu ambiente físico local (como instalar novas extensões no VS Code, mudar configurações de terminal ou prompts do Antigravity), você pode trazer essas atualizações para o repositório de forma limpa e higienizada.

### No Windows:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
.\scripts\backup-current-environment.ps1
```

### No Linux:
```bash
./scripts/backup-current-environment.sh
```

---

## 🛡️ Auditoria Preventiva de Segredos (Check Secrets)

Antes de realizar qualquer `git commit` ou `git push` no repositório público ou privado, certifique-se de passar o script de auditoria de segurança para garantir a ausência completa de chaves reais e secrets:

### No Windows:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
.\scripts\check-secrets.ps1
```

### No Linux:
```bash
./scripts/check-secrets.sh
```
