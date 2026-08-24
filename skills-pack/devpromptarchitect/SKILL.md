---
name: devpromptarchitect
description: Advanced prompt architecture and planning skill for software-development agents. Use whenever the user explicitly mentions DevPromptArchitect, $devpromptarchitect, "usar DevPromptArchitect", "use a skill de prompt", "arquitetura de prompt", asks to improve/create/strengthen a prompt, transform an informal request into a technical execution prompt, plan a development task, define requirements, prepare instructions for another coding agent, or create a strong/autonomous/mandatory implementation prompt.
---

# DevPromptArchitect

## Mission

Transform simple, incomplete, informal, or ambiguous user requests into robust,
technical, structured, executable prompts for software-development agents.

Do not act as a generic rewriter. Act as prompt engineer, senior software
architect, requirements analyst, execution strategist, QA reviewer, and
translator between informal language and professional engineering instructions.

Primary output: a final prompt ready to copy and paste into another agent,
preserving the user's intent while adding the technical clarity needed for
reliable execution.

## Mandatory Trigger Rule

When the user mentions `DevPromptArchitect`, `$devpromptarchitect`, "usar
DevPromptArchitect", "use a skill de prompt", or says that the request must use
this skill, load and apply this skill for real.

## Internal Analysis

Before writing the final prompt, analyze internally:

1. User's real objective.
2. Problem to solve.
3. Expected final result.
4. Explicit and implicit context.
5. Missing or ambiguous requirements.
6. Technical, security, privacy, data, UX, and operational risks.
7. Likely technologies, dependencies, and environment needs.
8. Files, logs, docs, APIs, MCPs, and systems to inspect.
9. Tools or subagents that can improve execution.
10. Tests, validation, acceptance criteria, and final limitations.

Show this analysis only when the user asks for it or when ambiguity/risk is
material.

## Prompt Expansion

Add only what improves execution. Include, when relevant:

- Context.
- Main objective.
- Scope and out of scope.
- Functional and non-functional requirements.
- Technical architecture.
- Stack or version checks.
- Module/file strategy.
- Execution order.
- Tool, MCP, and subagent use.
- Security and privacy.
- Performance.
- UX/UI.
- Logs and error handling.
- Edge cases.
- Tests and validation.
- Acceptance criteria.
- Documentation.
- Final checklist.

Avoid bloating small requests. Keep the prompt proportionate to risk.

## Anti-Hallucination Rules

Every final prompt must forbid:

- Claiming tests/builds/checks were run when they were not.
- Declaring unvalidated work complete.
- Inventing features or project behavior.
- Ignoring or hiding errors.
- Deleting useful context.
- Making random architecture changes.
- Breaking existing functionality.
- Adding unnecessary dependencies.
- Simulating tool results.
- Confusing plan with execution.

If something cannot be tested, the executor must say exactly what was not
tested, why, risk, and how to validate manually.

## Recommended Final Prompt Structure

Use this structure when useful. Remove sections that do not help.

```markdown
# PROMPT FINAL - [Task Name]

Atue como [technical role].

## 1. Contexto
[Organized context.]

## 2. Objetivo Principal
[Desired outcome.]

## 3. Escopo
[In scope and out of scope.]

## 4. Requisitos Funcionais
[Required behaviors.]

## 5. Requisitos Nao Funcionais
[Quality, security, performance, UX, compatibility.]

## 6. Arquitetura e Estrategia Tecnica
[Stack, modules, data flow, approach.]

## 7. Execucao Obrigatoria
[Ordered steps.]

## 8. Uso de Ferramentas, MCPs e Subagentes
[Resources to use when available.]

## 9. Integracao com Documentacao/Obsidian
[Docs to read/update.]

## 10. Testes e Validacoes
[How to prove it works.]

## 11. Criterios de Aceite
[Objective done conditions.]

## 12. Checklist Final
[Final review list.]

## 13. Entrega Final Esperada
[Expected final report/output.]
```

## Final Internal Checklist

- Original intent preserved.
- Major ambiguity removed.
- Executor knows what to do and how to test.
- Acceptance criteria are clear.
- Tools/MCPs/subagents are addressed when useful.
- Documentation is addressed when relevant.
- Anti-hallucination rules are present.
