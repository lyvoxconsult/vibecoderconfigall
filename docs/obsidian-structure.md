# 🧠 Estrutura do Obsidian como Segundo Cérebro (Second Brain)

O **Obsidian** atua como o seu cérebro digital e repositório central de conhecimento técnico, registro de decisões de engenharia, pendências de projetos comerciais e insights operacionais. A simbiose entre as suas ferramentas de IA (Codex e Antigravity) e o Obsidian é um dos pilares da sua alta performance.

Este guia documenta o blueprint da estrutura de pastas do cofre e define as regras para que as IAs possam interagir e atualizar o cofre sem comprometer a organização ou duplicar informações.

---

## 📂 Blueprint da Estrutura de Pastas do Obsidian

O cofre estruturado em `D:\Obsidian\obsidian` segue a seguinte arquitetura:

```text
D:\Obsidian\obsidian/
├── .obsidian/                      # Configurações do Obsidian (oculto e ignorado no Git)
│
├── AI-BRAIN/                       # Conhecimento operacional acumulado por IAs
│   ├── Prompts Reutilizáveis.md    # Catálogo de prompts e system instructions
│   ├── Padrões de Arquitetura.md    # Decisões de design de sistemas reutilizáveis
│   └── Configurações de Runtimes.md # Dicas de provisionamento rápido de APIs e Docker
│
├── Projetos/                       # Pasta individual para cada sistema/cliente
│   ├── Gerenciamento/              # Pasta do projeto Gerenciamento (exemplo)
│   │   ├── 00 - Visão Geral.md     # Escopo, arquitetura, dependências e links úteis
│   │   ├── Tarefas e Sprints.md    # TODO-list ativo do projeto
│   │   └── Decisões Técnicas.md    # Registro de decisões (ex: escolha do Supabase)
│   │
│   ├── CacambasGoOficial/           # Pasta do projeto Caçambas Go
│   │   ├── 00 - Visão Geral.md
│   │   └── Decisões Técnicas.md
│   │
│   └── Lyvox.com/                  # Pasta do site Lyvox
│       └── 00 - Visão Geral.md
│
├── 00 - Mapa Operacional do Vault.md # Índice geral de links e caminhos do cofre
├── Índice Geral de Projetos.md     # Painel central listando status de cada projeto
├── Mapa de Tecnologias.md          # Inventário de stacks recomendadas por nicho
├── Pendências Gerais dos Projetos.md # Agregador central de bugs e pendências
└── ARCHIVE/                        # Pasta de descarte para projetos e notas obsoletas
```

---

## 🤖 Como as IAs devem interagir com o Obsidian

### 1. Leitura e Consulta a Documentos Auxiliares (Contexto)
Tanto o Codex quanto o Antigravity possuem permissões de leitura recursivas na pasta `D:\Obsidian`. Sempre que uma tarefa envolver a modificação de um projeto (ex: `Gerenciamento` ou `CacambasGoOficial`), os agentes devem:
- Consultar preventivamente o arquivo `00 - Visão Geral.md` do projeto correspondente para entender regras arquiteturais e stack.
- Consultar `Mapa de Tecnologias.md` e `Índice Geral de Projetos.md` caso necessitem entender integrações entre sistemas do ecossistema.

### 2. Escrita Técnica e Logs de Decisão (Pós-Tarefa)
Ao finalizar com absoluto sucesso uma tarefa de refatoração estrutural, implementação de uma feature crítica ou resolução de um bug complexo, as IAs devem registrar esse aprendizado e mudança técnica:
- **O que registrar:** O que mudou no código, as razões técnicas por trás da mudança, os potenciais efeitos colaterais e o que foi feito para mitigar falhas.
- **Onde registrar:** No arquivo `Decisões Técnicas.md` da pasta do projeto correspondente.
- **Evitar Duplicação:** As IAs não devem transcrever o código inteiro da feature na nota do Obsidian, mas sim resumir a lógica conceitual de forma sucinta e profissional, mantendo a nota limpa e focada em negócios e arquitetura de alto nível.

---

## 🔒 Segurança e Privacidade das Notas do Obsidian

Como as notas do Obsidian residem no seu drive local e não são versionadas junto ao repositório público `vibecoderconfigall` (que armazena apenas os templates e modelos de Segundo Cérebro), você pode escrever livremente dados comerciais e descrições detalhadas do seu fluxo corporativo lá dentro.

Para ver os templates e blueprints vazios que outras pessoas podem utilizar como base, acesse:
- [obsidian/project-knowledge-base-template.md](file:///C:/Users/pedro/OneDrive/Documentos/00-Projetos/vibecoderconfigall/obsidian/project-knowledge-base-template.md)
- [obsidian/second-brain-structure.md](file:///C:/Users/pedro/OneDrive/Documentos/00-Projetos/vibecoderconfigall/obsidian/second-brain-structure.md)
