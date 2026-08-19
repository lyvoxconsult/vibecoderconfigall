#!/usr/bin/env bash
set -Eeuo pipefail
umask 027

source_dir="${LYVOX_DOCS_SOURCE:-}"
allowlist="${LYVOX_DOCS_ALLOWLIST:-}"
destination="${LYVOX_DOCS_DESTINATION:-${LYVOX_ROOT:-/opt/lyvox}/docs/lyvox-core/sanitized}"
approval="${LYVOX_DOCS_APPROVAL_FILE:-}"
apply=false
usage() { printf 'uso: %s --source DIR --allowlist FILE [--destination DIR] [--approval FILE] [--apply]\n' "$0" >&2; exit 2; }
while (($#)); do
  case "$1" in
    --source) source_dir="${2:-}"; shift 2 ;;
    --allowlist) allowlist="${2:-}"; shift 2 ;;
    --destination|--target) destination="${2:-}"; shift 2 ;;
    --approval) approval="${2:-}"; shift 2 ;;
    --apply) apply=true; shift ;;
    *) usage ;;
  esac
done
log() { printf '[docs-sync] %s\n' "$*"; }
die() { printf '[docs-sync] ERROR: %s\n' "$*" >&2; exit 1; }
as_root() { if (( EUID == 0 )); then "$@"; else command sudo "$@"; fi; }
[[ -d "$source_dir" && -f "$allowlist" ]] || usage
source_real="$(realpath -- "$source_dir")"
tmp_root="$(mktemp -d)"; trap 'rm -rf -- "$tmp_root"' EXIT
approved_list="$tmp_root/approved.tsv"; : >"$approved_list"

sensitivity_of() {
  awk 'NR==1 && $0!="---"{exit} NR>1 && $0=="---"{exit} NR>1 && /^sensitivity:[[:space:]]*/{sub(/^sensitivity:[[:space:]]*/,"");gsub(/"/,"");gsub(/\047/,"");print tolower($0);exit}' "$1"
}
sanitize_frontmatter() {
  awk 'NR==1&&$0=="---"{front=1;print;next} front&&$0=="---"{front=0;skip=0;print;next} front&&/^(source_paths|source_files|source_hashes):/{skip=1;next} front&&skip&&/^[[:space:]]+-/{next} front&&skip&&/^[A-Za-z0-9_-]+:/{skip=0} !skip{print}' "$1"
}

count=0
while IFS= read -r raw || [[ -n "$raw" ]]; do
  relative="${raw%$'\r'}"
  relative="${relative#"${relative%%[![:space:]]*}"}"
  relative="${relative%"${relative##*[![:space:]]}"}"
  [[ -n "$relative" && "$relative" != \#* ]] || continue
  [[ "$relative" != /* && "$relative" != *'..'* && "$relative" == *.md ]] || die "entrada insegura na allowlist: $relative"
  [[ ! "$relative" =~ (^|/)(\.git|\.obsidian|90-ARCHIVE|99-RESTRICTED-INDEX|_backups|restricted[^/]*|private[^/]*|clientes?[^/]*|contratos?[^/]*|banc[aá]rio[^/]*|societ[aá]rio[^/]*|logs?[^/]*|sessions?[^/]*)(/|$) ]] || die "caminho bloqueado: $relative"
  current="$source_real/$relative"; [[ -f "$current" && ! -L "$current" ]] || die "arquivo ausente ou symlink: $relative"
  resolved="$(realpath -- "$current")"; [[ "$resolved" == "$source_real/"* ]] || die "arquivo fora da origem: $relative"
  sensitivity="$(sensitivity_of "$resolved")"; [[ "$sensitivity" == public || "$sensitivity" == internal ]] || die "sensibilidade ausente/bloqueada: $relative"
  staged="$tmp_root/files/$relative"; mkdir -p "$(dirname -- "$staged")"; sanitize_frontmatter "$resolved" >"$staged"
  if grep -IqiE -- '-----BEGIN .*PRIVATE KEY-----|(postgres(ql)?|mongodb(\+srv)?)://[^[:space:]]+:[^[:space:]@]+@|(^|[^[:alnum:]_-])sk-(proj-)?[A-Za-z0-9_-]{20,}([^[:alnum:]_-]|$)|github_pat_[A-Za-z0-9_]{50,}|AKIA[0-9A-Z]{16}|eyJ[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}\.[A-Za-z0-9_-]{10,}|[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}-?[0-9]{2}|[0-9]{2}\.?[0-9]{3}\.?[0-9]{3}/?[0-9]{4}-?[0-9]{2}|[[:alnum:]._%+-]+@[[:alnum:].-]+\.[A-Za-z]{2,}|\+?[0-9][0-9 ()-]{9,}[0-9]|[A-Za-z]:\\(Users|Documentos|Obsidian|Lyvox)' "$staged"; then die "assinatura sensível após sanitização: $relative"; fi # scanner-pattern-literal
  printf '%s\t%s\n' "$relative" "$sensitivity" >>"$approved_list"; count=$((count + 1)); log "DRY-RUN aprovado: $relative"
done <"$allowlist"
((count > 0)) || die "allowlist não selecionou documentos"
selection_manifest="$tmp_root/SELECTION.sha256"
(cd "$tmp_root/files" && find . -type f -name '*.md' -print0 | sort -z | xargs -0 sha256sum >"$selection_manifest")
selection_hash="$(sha256sum "$selection_manifest" | awk '{print $1}')"
log "REVIEW_SELECTION_SHA256=$selection_hash"
[[ "$apply" == true ]] || { log "$count documento(s) aprovados; revise e repita com --approval FILE --apply"; exit 0; }
[[ -f "$approval" ]] || die "--apply exige arquivo --approval revisado"
approved_by="$(sed -n 's/^approved_by=//p' "$approval" | tail -n1)"
approved_hash="$(sed -n 's/^selection_sha256=//p' "$approval" | tail -n1)"
[[ -n "$approved_by" && "$approved_hash" == "$selection_hash" ]] || die "identidade/hash da aprovação não corresponde ao conteúdo atual"
stamp="$(date -u +%Y%m%dT%H%M%SZ)"; snapshot="$destination/snapshot-$stamp"
as_root install -d -m 0750 "$snapshot"
as_root rsync -a "$tmp_root/files/" "$snapshot/"
as_root install -m 0640 "$approved_list" "$snapshot/INDEX.tsv"
as_root install -m 0640 "$selection_manifest" "$snapshot/MANIFEST.sha256"
log "snapshot sanitizado criado: $snapshot"
