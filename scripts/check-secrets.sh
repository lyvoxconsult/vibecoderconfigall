#!/usr/bin/env bash
set -Eeuo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd -P)"
while (($#)); do
  case "$1" in
    --path) ROOT="$(cd "${2:-}" && pwd -P)"; shift 2 ;;
    *) echo "uso: $0 [--path DIR]" >&2; exit 2 ;;
  esac
done

findings=0
report() { printf '[secrets] %s\n' "$*" >&2; findings=$((findings + 1)); }
files=()
while IFS= read -r -d '' path; do
  rel="${path#"$ROOT"/}"
  case "$rel" in
    .git/*|node_modules/*|dist/*|build/*|graphify-out/*|scripts/check-secrets.sh) continue ;;
  esac
  files+=("$path")
  base="$(basename -- "$path")"
  case "$base" in
    .env.example|*.env.example) ;;
    .env|.env.*|*.pem|*.key|*.p12|*.pfx|*.sqlite|*.sqlite3|*.db) report "arquivo sensível proibido: $rel" ;;
  esac
done < <(
  find "$ROOT" \( -path "$ROOT/.git" -o -path "$ROOT/node_modules" -o -path "$ROOT/graphify-out" \) -prune -o -type f -print0
)

labels=(PRIVATE_KEY AWS_KEY GITHUB_TOKEN OPENAI_KEY SLACK_TOKEN TELEGRAM_TOKEN JWT DATABASE_URL ASSIGNED_SECRET)
patterns=(
  '-----BEGIN (RSA |EC |OPENSSH |DSA )?PRIVATE KEY-----'
  '(^|[^A-Z0-9])AKIA[0-9A-Z]{16}([^A-Z0-9]|$)'
  '(^|[^[:alnum:]_])gh[pousr]_[A-Za-z0-9_]{30,}([^[:alnum:]_]|$)'
  '(^|[^[:alnum:]_-])sk-(proj-)?[A-Za-z0-9_-]{20,}([^[:alnum:]_-]|$)'
  '(^|[^[:alnum:]-])xox[baprs]-[A-Za-z0-9-]{20,}([^[:alnum:]-]|$)'
  '(^|[^0-9])[0-9]{8,10}:[A-Za-z0-9_-]{35}([^A-Za-z0-9_-]|$)'
  '(^|[^[:alnum:]_-])eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}([^[:alnum:]_-]|$)'
  '(postgres(ql)?|mongodb(\+srv)?)://[^[:space:]]+:[^[:space:]@]+@'
  '(password|passwd|secret|token|api[_-]?key|connection[_-]?string)[[:space:]]*[:=][[:space:]]*[^[:space:]<>{}]{12,}'
)
for index in "${!patterns[@]}"; do
  for file in "${files[@]}"; do
    matches="$(grep -InE -- "${patterns[$index]}" "$file" || true)"
    rel="${file#"$ROOT"/}"
    if [[ "$rel" == scripts/sync-lyvox-core-sanitized.sh || "$rel" == "skills obrigatorias/sync-skills.sh" ]]; then
      matches="$(printf '%s\n' "$matches" | grep -v 'scanner-pattern-literal' || true)"
    fi
    if [[ -n "$matches" ]]; then
      lines="$(printf '%s\n' "$matches" | cut -d: -f1 | paste -sd, -)"
      report "${labels[$index]}: $rel linha(s) $lines"
    fi
  done
done
if ((findings > 0)); then printf '[secrets] FALHA: %d achado(s)\n' "$findings" >&2; exit 1; fi
echo '[secrets] PASS: nenhuma assinatura de alta confiança ou arquivo proibido encontrado.'
