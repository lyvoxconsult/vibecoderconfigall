# PROMPT FINAL - Configurar MacBook com Codex, Antigravity, Skills e Obsidian

Atue como engenheiro senior de ambiente de desenvolvimento, especialista em macOS, Codex, Antigravity, MCPs, skills e governanca de documentacao tecnica.

## 1. Contexto

Voce esta em um MacBook novo ou recem-configurado. O repositorio `vibecoderconfigall` contem prompts globais, regras de agentes, exemplos de configuracao, skills obrigatorias, skills de referencia, templates e orientacoes para uso do Obsidian como fonte de contexto.

O objetivo e reconstruir o ambiente diario de trabalho sem copiar segredos, sem assumir caminhos de outro sistema operacional e sem trazer residuos historicos. O caminho real do vault Obsidian, dos projetos, das configuracoes do Codex e das configuracoes do Antigravity deve ser descoberto localmente ou solicitado ao usuario.

## 2. Objetivo Principal

Configurar no Mac um ambiente funcional para Codex e Antigravity usando este repositorio como fonte de configuracoes, prompts, skills e referencias, preservando seguranca, portabilidade e rastreabilidade.

## 3. Escopo

Incluido:

- Auditar ferramentas existentes no Mac.
- Instalar ou orientar instalacao de dependencias ausentes sem acionar servicos pagos.
- Configurar prompts globais e regras de agente.
- Copiar skills obrigatorias e referencias aprovadas.
- Aplicar o contrato atual de skills: pack obrigatorio, `find-skills`, skills por gatilho e skills obrigatorias condicionais por dominio.
- Configurar exemplos MCP com placeholders seguros.
- Configurar permissoes de leitura/escrita para projetos e Obsidian usando caminhos reais do Mac.
- Validar setup com comandos reais.
- Produzir relatorio final objetivo.

Fora de escopo:

- Copiar credenciais reais para o Git.
- Copiar codigo comercial ou documentos restritos para este repositorio.
- Instalar catalogos brutos de skills automaticamente sem revisao.
- Alterar projetos do usuario sem pedido explicito.
- Declarar sucesso sem validacao real.

## 4. Requisitos Funcionais

- Detectar sistema, shell, usuario, Homebrew, Git, Node.js, pnpm, Python, uv, VS Code, Codex, Antigravity e Obsidian.
- Ler antes de agir:
  - `README.md`
  - `QUICK_START.md`
  - `SECURITY_NOTES.md`
  - `agents/global-agent-rules.md`
  - `agents/codex-global-prompt.md`
  - `agents/antigravity-global-prompt.md`
  - `skills obrigatorias/README.md`
  - `skills obrigatorias/skills-manifest.json`
  - `skills obrigatorias/mandatory-10-skills.md`
  - `docs/SKILLS_INDEX.md`
  - `docs/codex-setup.md`
  - `docs/antigravity-setup.md`
  - `obsidian/documentation-architecture.md`
- Descobrir ou pedir os caminhos locais reais para:
  - raiz de projetos;
  - vault Obsidian;
  - configuracao Codex;
  - configuracao Antigravity;
  - destino de skills locais.
- Copiar arquivos apenas para destinos confirmados.
- Manter `.env` local fora do Git.
- Trocar placeholders por caminhos locais somente em arquivos nao versionados ou configs locais do Mac.
- Preservar backups de arquivos existentes antes de sobrescrever.

## 5. Requisitos Nao Funcionais

- Diff minimo e reversivel.
- Sem segredos em logs ou arquivos versionados.
- Sem dependencias pagas sem autorizacao explicita.
- Sem comandos destrutivos.
- Compatibilidade com macOS atual.
- Comunicacao final em pt-BR, objetiva e com evidencias.

## 6. Estrategia Tecnica

1. Auditar o ambiente atual em modo somente leitura.
2. Validar o repositorio com scripts existentes.
3. Montar matriz de origem e destino para prompts, skills, MCPs e configs.
4. Fazer backup dos arquivos locais que seriam substituidos.
5. Aplicar configuracoes em etapas pequenas.
6. Rodar validacoes apos cada etapa critica.
7. Documentar o que foi feito e o que ficou pendente.

## 7. Uso de Ferramentas e Subagentes

Use ferramentas locais de terminal para inspecao e validacao. Quando houver suporte no ambiente, use subagentes ou papeis simulados:

- Arquitetura: revisar limites entre repo, IDEs, skills e Obsidian.
- Seguranca: revisar segredos, permissoes e arquivos sensiveis.
- QA: validar comandos, existencia de arquivos e ausencia de referencias indevidas.
- Documentacao: revisar clareza das instrucoes e atualizar notas permitidas.

## 8. Integracao com Obsidian

Use Obsidian como segundo cerebro/documentacao de contexto. Nao presuma caminho fixo. O vault correto deve ser informado pelo usuario ou descoberto no Mac.

Boas praticas obrigatorias:

- Consultar notas relevantes antes de alterar projetos importantes.
- Tratar notas como contexto, nao como verdade absoluta.
- Quando houver divergencia, codigo, testes, manifests e runtime atuais prevalecem.
- Registrar ao final objetivo, decisoes, arquivos analisados/alterados, validacoes, riscos e pendencias.
- Nao colar codigo inteiro, logs extensos, segredos ou transcricoes de chat em notas.

## 9. Testes e Validacoes

Execute e registre saidas relevantes:

```bash
git status --short --branch
pwsh ./scripts/validate-repo.ps1 || bash ./scripts/validate-repo.sh
pwsh ./scripts/check-secrets.ps1 || bash ./scripts/check-secrets.sh
```

Tambem valide:

- arquivos de destino existem;
- backups foram criados antes de sobrescrita;
- prompts globais foram instalados no local correto;
- skills obrigatorias estao no destino esperado;
- configs MCP nao contem segredos;
- Obsidian foi referenciado por caminho local confirmado.

## 10. Criterios de Aceite

- Codex e Antigravity conseguem ler os prompts/regras instalados.
- Skills obrigatorias foram copiadas ou pendencias foram justificadas.
- `find-skills` e as skills condicionais por dominio ficaram disponiveis ou foram listadas como pendencia justificada.
- Configuracoes locais usam caminhos do Mac, nao caminhos herdados de outro sistema.
- Nenhum segredo foi versionado.
- O repositorio segue validando.
- O relatorio final separa confirmado, pendente e nao testado.

## 11. Regras Anti-Alucinacao

E proibido:

- afirmar que instalou, copiou, testou ou validou algo sem evidencia;
- esconder erro de comando;
- inventar caminho local;
- sobrescrever configuracao sem backup;
- instalar pacote pago ou desconhecido sem autorizacao;
- copiar todo o acervo bruto de skills sem revisao;
- confundir plano com execucao.

Se algo nao puder ser testado, informe exatamente o que nao foi testado, por que, risco e como validar manualmente.

## 12. Entrega Final Esperada

Entregue um resumo curto contendo:

- arquivos/configs instalados;
- caminhos locais usados;
- comandos executados;
- validacoes aprovadas;
- falhas ou pendencias;
- proximos passos manuais.
