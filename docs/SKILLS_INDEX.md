# Índice seguro de skills

Fonte operacional: `skills obrigatorias/skills-manifest.json`. O manifest registra o pack obrigatório, `find-skills`, skills adicionais por gatilho e skills obrigatórias condicionais por domínio. `lyvox-core-reader` permanece pendente de criação/revisão e não deve ser simulada.

`skills-pack/` é catálogo histórico de referência. Ele não é fonte confiável automática, não é copiado integralmente para ambientes globais e pode conter exemplos que acionam scanners de secrets. Licença, proveniência, symlinks e conteúdo devem ser revisados por skill.

## Fluxo autorizado

```bash
./scripts/update-skills.sh --source "$HOME/.codex/skills"
cp "skills obrigatorias/skills-approval.example" /tmp/skills-approval
# preencher reviewer e REVIEW_SELECTION_SHA256 exibido no dry-run
./scripts/update-skills.sh --source "$HOME/.codex/skills" --approval /tmp/skills-approval --apply
```

O dry-run é obrigatório antes de `--apply`. A aplicação exige hash do conteúdo selecionado, `SKILL.md`, ausência de arquivos sensíveis e ausência de qualquer symlink na skill.

Não use `robocopy`, `cp -R` ou sync integral de catálogos para superfícies globais.
