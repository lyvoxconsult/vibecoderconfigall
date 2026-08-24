#!/usr/bin/env bash
set -Eeuo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
errors=0

for command_name in git bash; do
  if command -v "$command_name" >/dev/null 2>&1; then
    printf '[validate] ok: %s\n' "$command_name"
  else
    printf '[validate] missing: %s\n' "$command_name" >&2
    ((errors+=1))
  fi
done

for optional_command in pwsh node python3 rg jq; do
  if command -v "$optional_command" >/dev/null 2>&1; then
    printf '[validate] optional ok: %s\n' "$optional_command"
  else
    printf '[validate] optional missing: %s\n' "$optional_command"
  fi
done

required_paths=(
  "$REPO_ROOT/agents"
  "$REPO_ROOT/configs"
  "$REPO_ROOT/docs"
  "$REPO_ROOT/mcp"
  "$REPO_ROOT/scripts"
  "$REPO_ROOT/skills obrigatorias"
)

for path in "${required_paths[@]}"; do
  if [[ -e "$path" ]]; then
    printf '[validate] path ok: %s\n' "${path#$REPO_ROOT/}"
  else
    printf '[validate] missing path: %s\n' "${path#$REPO_ROOT/}" >&2
    ((errors+=1))
  fi
done

bash "$REPO_ROOT/scripts/validate-repo.sh" || ((errors+=1))
bash "$REPO_ROOT/scripts/check-secrets.sh" || ((errors+=1))

((errors == 0)) || {
  echo "[validate] $errors erro(s)" >&2
  exit 1
}

echo "[validate] ambiente valido"
