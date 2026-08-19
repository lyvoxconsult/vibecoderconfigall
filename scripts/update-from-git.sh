#!/usr/bin/env bash
set -Eeuo pipefail
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"; cd "$REPO_ROOT"
[[ -d .git ]] || { echo "[update] não é clone Git" >&2; exit 1; }
[[ -z "$(git status --porcelain)" ]] || { echo "[update] worktree sujo; atualização abortada" >&2; exit 1; }
branch="$(git branch --show-current)"; [[ -n "$branch" ]] || { echo "[update] detached HEAD" >&2; exit 1; }
git fetch --prune origin; git merge --ff-only "origin/$branch"
echo "[update] atualizado em fast-forward; rode bootstrap.sh explicitamente para aplicar infraestrutura"
