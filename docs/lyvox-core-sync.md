# Sincronização sanitizada do Lyvox Core

## Fonte e limites

- Fonte canônica local: `D:\Lyvox Core\Lyvox Core`.
- Destino esperado na VPS: `/opt/lyvox/docs/lyvox-core/sanitized`.
- O código, runtime, migrations, manifests e testes atuais prevalecem quando divergirem da documentação.
- `Rockscore` não foi confirmado como alias de Lyvox Core. Não renomeie diretórios, notas ou conceitos sem decisão documental explícita.
- O sync é somente de leitura na origem. O Lyvox Core original nunca é alterado por este repositório.

## Política de seleção

O processo é deny-by-default. Uma nota só pode entrar no snapshot quando:

1. estiver em uma allowlist versionada e revisada por humano;
2. tiver `sensitivity: public` ou `sensitivity: internal`;
3. não contiver PII, credenciais, tokens, cookies, JWTs, connection strings, dados bancários, societários, contratuais ou de clientes;
4. não estiver em `99-RESTRICTED-INDEX`, `90-ARCHIVE`, backups, lixeiras ou registries restritos;
5. passar pela varredura de secrets e por revisão do diff.

`restricted`, `confidential`, `secret`, sensibilidade ausente/ilegível e qualquer classificação desconhecida são bloqueadas. Metadados de um item restrito também não devem ser publicados quando puderem revelar identidade, negócio ou localização do conteúdo.

## Fluxo seguro

1. Criar/revisar `docs/lyvox-core-allowlist.txt` com caminhos Markdown relativos exatos.
2. Executar o dry-run em máquina autorizada:

   ```bash
   ./scripts/sync-lyvox-core-sanitized.sh \
     --source /caminho/do/lyvox-core \
     --allowlist docs/lyvox-core-allowlist.txt
   ```

3. Copiar `docs/lyvox-core-approval.example`, preencher o responsável e o `REVIEW_SELECTION_SHA256` exibido no dry-run.
4. Após revisão humana, repetir com `--approval /caminho/aprovacao --apply`.
5. O script gera snapshot imutável, `INDEX.tsv` e `MANIFEST.sha256`.
6. Rodar `scripts/check-secrets.sh --path /caminho/do/snapshot` no staging e `scripts/check-secrets.sh` no repositório.
7. Revisar manualmente o snapshot e aprovar a promoção.
8. Registrar data, origem, aprovador, itens incluídos/excluídos e resultado do scan.

Nunca faça sync direto do vault inteiro, use glob amplo, siga symlinks ou copie anexos por padrão. Se a classificação não puder ser validada, interrompa a inclusão daquele arquivo.

## Índice obrigatório do snapshot

O índice deve registrar apenas metadados não sensíveis: caminho relativo, título público/interno, classificação, hash, data do snapshot e decisão `included`. Não registre conteúdo ou nomes de arquivos bloqueados.

## Rollback

Snapshots são imutáveis e identificados por timestamp. Em erro, remova o snapshot afetado do destino, restaure o último snapshot aprovado e registre o incidente. A origem canônica permanece intocada.
