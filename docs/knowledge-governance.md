# Governança de conhecimento Lyvox

## Autoridade

| Domínio | Fonte primária | Regra de desempate |
|---|---|---|
| Conhecimento institucional | `D:\Lyvox Core\Lyvox Core` | autoridade, status, confiança e vigência do frontmatter |
| Desenvolvimento | código, migrations, manifests e testes atuais | o estado executável prevalece sobre docs antigas |
| Skills | `C:\Users\pedro\.codex\skills` | `.agents\skills` é compatibilidade quando existir |
| Runtime VPS | configuração e estado observado na VPS | validar antes de documentar como atual |

`Rockscore` é um termo não confirmado neste contexto. Não o trate como alias, produto ou substituto do Lyvox Core sem evidência e aprovação.

## Classificação e publicação

- `public`: pode ser publicado após scan e revisão.
- `internal`: pode entrar em snapshot sanitizado somente por allowlist e aprovação.
- `restricted`, `confidential`, `secret`: nunca entram no Git ou na VPS documental compartilhada.
- ausente/desconhecida: bloqueada até classificação humana.

Além da classificação, remova PII, segredos, dados de clientes, jurídicos, financeiros, bancários e societários. Sanitização não converte automaticamente material restrito em publicável.

## Ciclo de vida

1. Descoberta: consultar MOCs e registries antes de pesquisar em profundidade.
2. Validação: confirmar fonte, owner, vigência, confiança e estado real do código/runtime.
3. Aprovação: exigir humano para publicação, automações destrutivas, mudança de autoridade e exposição externa.
4. Distribuição: usar snapshot sanitizado versionado, nunca montar o vault canônico em container público.
5. Revisão: definir `review_at`, registrar divergências e remover snapshots obsoletos.

## Divergências

Quando docs e sistema real divergirem, não edite automaticamente o Lyvox Core. Registre a divergência no relatório de execução, indique a evidência operacional e encaminhe atualização documental para aprovação. Este bootstrap não autoriza alterações no Gerenciamento nem no Lyvox Core original.

## Rastreabilidade mínima

Cada execução relevante registra objetivo, decisões, fontes consultadas, arquivos alterados, validações reais, limitações, riscos residuais, aprovador e próxima ação. Resultados não executados devem ser marcados como pendentes, nunca simulados.
