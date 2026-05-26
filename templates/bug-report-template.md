# 🐛 Relatório e Análise de Erro (Bug Report)

Use este template para registrar bugs detectados nas aplicações comerciais de forma estruturada.

---

## 🚨 Descrição do Problema
- **O que está quebrado?** [Descrição curta do comportamento inesperado].
- **Severidade:** [Crítica / Alta / Média / Baixa]
- **Onde ocorre:** [Endpoint de API, página de frontend, fluxo específico de navegação].

---

## 📈 Comportamento Esperado vs. Atual
- **Esperado:** [O que deveria acontecer na aplicação].
- **Atual:** [O que realmente acontece, ex: erro HTTP 500, página em branco ou botão inativo].

---

## 🔍 Diagnóstico e Stack Trace (Logs)
Transcreva logs relevantes e mensagens de erro do terminal ou console do navegador:

```text
Error: [Cole aqui a mensagem de erro exata e a stack trace se aplicável]
```

---

## 🛠️ Proposta de Correção e Mitigação
1. **Lógica da Solução:** [Como corrigir a falha sem quebrar áreas existentes].
2. **Prevenção de Regressão:** [Qual teste ou validação de tipo Zod será inserido para impedir que o erro volte a acontecer no futuro].
