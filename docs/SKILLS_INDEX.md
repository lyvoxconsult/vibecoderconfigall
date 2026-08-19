# Índice seguro de skills

Fonte operacional: `skills/skills-manifest.json`. O manifest contém 11 entradas: dez disponíveis no ambiente consultado e `lyvox-core-reader` pendente de criação/revisão. `devpromptarchitect` integra o conjunto obrigatório deste repositório.

`skills-pack/` é catálogo histórico de referência. Ele não é fonte confiável automática, não é copiado integralmente para a VPS e pode conter exemplos que acionam scanners de secrets. Licença, proveniência, symlinks e conteúdo devem ser revisados por skill.

## Fluxo autorizado

```bash
./scripts/update-skills.sh --source "$HOME/.codex/skills"
cp skills/skills-approval.example /tmp/skills-approval
# preencher reviewer e REVIEW_SELECTION_SHA256 exibido no dry-run
./scripts/update-skills.sh --source "$HOME/.codex/skills" --approval /tmp/skills-approval --apply
```

O dry-run é obrigatório antes de `--apply`. A aplicação exige hash do conteúdo selecionado, `SKILL.md`, ausência de arquivos sensíveis e ausência de qualquer symlink na skill.

Não use `robocopy`, `cp -R` ou sync integral de catálogos para superfícies globais.
