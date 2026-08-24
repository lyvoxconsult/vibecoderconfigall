# Arquitetura de Documentacao para Agentes

Este guia define como Codex, Antigravity e outros agentes devem usar Obsidian para contexto tecnico.

## Filosofia

Documentacao boa reduz incerteza. Documentacao excessiva, desatualizada ou cheia de logs atrapalha o agente.

## Regras

1. Escreva o motivo das decisoes, nao uma copia da implementacao.
2. Nao transcreva arquivos inteiros de codigo.
3. Nao cole logs extensos, credenciais, payloads sensiveis ou conversas brutas.
4. Use Markdown limpo compativel com Obsidian.
5. Use wikilinks para conectar projeto, tecnologia, decisao e aprendizado.
6. Mantenha notas pequenas, revisaveis e datadas quando a decisao depender de contexto temporal.

## Fonte de Verdade

Obsidian fornece contexto e historico. Codigo, testes, manifests, migrations, configuracoes reais e runtime atual prevalecem quando houver divergencia.

## Modelo de Registro Pos-Tarefa

```markdown
---
type: execution-note
status: done
---

# [Projeto] - [Resumo da tarefa]

## Objetivo

## Decisoes

## Arquivos analisados/alterados

## Validacoes

## Riscos e pendencias
```

## Permissoes

O agente so deve escrever em notas/diretorios autorizados pelo usuario. Quando nao houver autorizacao, entregue o resumo no chat ou em arquivo local do projeto.
