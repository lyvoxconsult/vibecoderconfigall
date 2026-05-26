# 🪐 Configuração e Provisionamento do Antigravity

O **Antigravity** é o seu ambiente principal e IDE de desenvolvimento integrada de IA. Ele é projetado para atuar como arquiteto e designer de software, com capacidades avançadas de interações de UI/UX premium via Stitch, automações complexas do ecossistema e tomadas de decisão estruturadas.

---

## 📂 Arquivos de Configuração Relacionados

- [configs/antigravity/config.example.json](file:///C:/Users/pedro/OneDrive/Documentos/00-Projetos/vibecoderconfigall/configs/antigravity/config.example.json) (Configurações de permissões globais de arquivos e caminhos de sistema)
- [agents/antigravity-global-prompt.md](file:///C:/Users/pedro/OneDrive/Documentos/00-Projetos/vibecoderconfigall/agents/antigravity-global-prompt.md) (System prompt customizado para Antigravity)

---

## 🛠️ Passo a Passo de Restauração de Ambiente

Para provisionar as configurações de comportamento e permissão do Antigravity em um novo computador:

1. **Instale e Provisione o Diretório do Config:**
   Garanta que a pasta do Antigravity existe na raiz do seu usuário do sistema:
   `C:\Users\SEU_USUARIO\.gemini\config`

2. **Injete as Permissões Seguras:**
   Utilize o script de restauração que copia o arquivo de configurações e permissões globais, ajustando os nomes dos caminhos de diretório locais:
   ```powershell
   .\scripts\restore-windows.ps1
   ```

3. **Valide a Configuração Local:**
   Execute o script de validação para garantir que o Antigravity reconhece o ambiente, as permissões para ler e escrever no Obsidian e nos projetos, e que os MCPs associados (Stitch, Supabase) estão ativos e comunicando com sucesso:
   ```powershell
   .\installers\windows\validate.ps1
   ```

---

## 💡 Princípios e Práticas Recomendadas

- **Aesthetics First (Visual Premium):** O Antigravity tem o compromisso de criar e manter interfaces ricas de altíssima qualidade visual (cores harmoniosas, gradientes suaves, tipografia refinada do Google Fonts e animações fluidas via micro-interações). Exija sempre um visual "uau" no front-end.
- **Delegação Ativa via Subagentes:** O Antigravity deve ser instruído a usar ativamente o subagente especialista em cada fase do ciclo de desenvolvimento, delegando a escrita de testes unitários ou auditorias de segurança para instâncias focadas.
- **Uso Estrito de Skills:** As skills contidas na pasta `/skills/` do repositório devem ser carregadas e consultadas constantemente pelo Antigravity para manter a padronização e evitar a criação de gambiarras ou duplicações arquiteturais.
- **Validação Antecipada (Zero Bugs):** Antes de concluir qualquer tarefa e dar a entrega por terminada, o Antigravity deve simular ou executar testes funcionais na aplicação e gerar relatórios de conformidade. É proibido simular sucesso de forma verbal.
