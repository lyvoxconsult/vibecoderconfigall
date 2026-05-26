# 🏗️ Arquitetura de Registro e Escrita Técnica para IAs

Este guia define a filosofia e as regras operacionais para documentar sistemas e processos usando a integração de IAs (Codex, Antigravity) com o Obsidian, visando manter o seu cérebro digital limpo, enxuto e livre de poluição de dados irrelevantes.

---

## ⚖️ A Filosofia do Registro Enxuto (Lean Documentation)

Documentação poluída e desatualizada é pior do que ausência de documentação. Para garantir que as IAs possam consumir as suas notas sem estourar o limite de tokens ou receber dados desatualizados, siga estes 3 pilares:

1. **Apenas Conceitos e Estrutura (High-Level First):**
   - As notas no Obsidian devem descrever a *arquitetura*, o *motivo* das decisões e a *estrutura geral* de pastas e serviços de um projeto.
   - **NÃO** transcreva arquivos inteiros de código-fonte nas notas. O código reside nos repositórios Git, e a IA pode lê-los diretamente da pasta do projeto.
2. **Justificativa sobre Implementação (The "Why" over "How"):**
   - Registrar *por que* algo foi implementado de determinada forma é 10x mais valioso do que registrar *como*.
   - Exemplo ruim: *"Adicionamos o comando `app.use(cors())` no express na linha 14 para habilitar requisições globais."*
   - Exemplo bom: *"CORS configurado de forma restrita para aceitar apenas domínios da Lyvox, visando bloquear chamadas de origem externa não autorizadas e proteger os endpoints da API."*
3. **Única Fonte da Verdade (Single Source of Truth):**
   - Evite duplicar informações do projeto que já estão descritas no `package.json` ou no `.env.example`. A IA deve ler essas dependências e variáveis dos próprios arquivos do projeto para evitar desalinhamento.

---

## 🤖 Regras Estritas de Interação para Agentes de IA

Sempre que você delegar tarefas de escrita para Codex ou Antigravity na pasta do Obsidian:

- **Não crie novos arquivos sem autorização:** Os agentes devem alterar apenas os arquivos correspondentes do projeto (`00 - Visão Geral.md`, `Decisões Técnicas.md` ou `Tarefas e Sprints.md`) ou a pasta `AI-BRAIN/`.
- **Formatação Limpa:** As notas devem usar formatação markdown pura compatível com Obsidian (sem tags HTML complexas ou formatações proprietárias).
- **Sem Logs Verbosos de Conversa:** O log de decisões técnicas deve ser uma nota limpa e conceitual, e não uma transcrição inteira das mensagens trocadas no chat do Antigravity.
