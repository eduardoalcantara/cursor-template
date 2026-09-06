#!/usr/bin/env bash
# scaffold-repo.sh — materializa a estrutura canônica do template Cursor
# Vive na RAIZ do template (pasta destino ainda vazia não tem scripts/).
set -euo pipefail

VERSION="1.0.0"
MANIFEST_NAME=".scaffold-manifest"
SOURCE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_ROOT="$(pwd)"
MODE_UNINSTALL=0
QUIET=0
FORCE=0
SSH=0
LOG=""
DEST_SET=0

FILE_LIST=(
  .gitignore
  .cursorignore
  readme.md
  spec-project-bootstrap.md
  spec-root.md
  flow.md
  rules.md
  status.md
  timeline.md
  setup.md
  tools-linux.md
  tools-windows.md
  .cursorrules
  .prompt-status
  spec-template.md
  rules-scripts.md
  scaffold-repo.ps1
  scaffold-repo.sh
  docs/readme.md
  ideas/readme.md
  specs/readme.md
  specs/to-do/readme.md
  specs/done/readme.md
  specs/optional/readme.md
  specs/optional/bootstrap-personalizar-projeto.md
  specs/optional/software-multi-produto.md
  references/readme.md
  scripts/readme.md
  scripts/bootstrap/readme.md
  scripts/validation/readme.md
  scripts/validation/validate-structure.sh
  scripts/validation/validate-structure.ps1
  scripts/automation/readme.md
  scripts/maintenance/readme.md
  reports/readme.md
  prompts/readme.md
  prompts/so-investigar.md
  prompts/revisar-diff.md
  prompts/fechar-sessao-handoff.md
  prompts/validar-estrutura.md
  resources/readme.md
  resources/downloads/.gitkeep
  core/readme.md
)

usage() {
  cat <<'EOF'
Uso: scaffold-repo.sh [--target <pasta>] [--uninstall] [--quiet|-q] [--force|-f] [--ssh] [--log <arquivo>] [--help]

Materializa (ou remove) a árvore canônica do template Cursor.
Scripts na RAIZ do template — pasta vazia ainda não tem scripts/.

  --target <pasta>   Destino (default: diretório atual)
  --uninstall        Remove apenas o que o manifest registra
  --quiet / -q       Sem prompts; assume defaults
  --force / -f       Autoriza sobrescrever / uninstall com --quiet/--ssh
  --ssh              Modo agente; exige --target e --log
  --log <arquivo>    Espelha saída no arquivo
  --help             Ajuda

Fonte = pasta deste script (deve conter spec-project-bootstrap.md).
EOF
}

log_line() {
  if [[ -n "$LOG" ]]; then
    printf '%s\n' "$*" >>"$LOG"
  fi
}

out() {
  printf '%s\n' "$*"
  log_line "$*"
}

die() {
  printf '%s\n' "$*" >&2
  log_line "$*"
  exit 1
}

cyan() {
  if [[ -t 1 ]]; then
    printf '\033[36m%s\033[0m\n' "$*"
  else
    printf '%s\n' "$*"
  fi
  log_line "$*"
}

header() {
  local mode="$1"
  if [[ "$QUIET" -eq 0 && "$SSH" -eq 0 && -t 1 ]] && command -v clear >/dev/null 2>&1; then
    clear
  fi
  local src="$SOURCE_ROOT" dst="$TARGET_ROOT"
  [[ ${#src} -gt 48 ]] && src="...${src: -45}"
  [[ ${#dst} -gt 48 ]] && dst="...${dst: -45}"
  cyan '╔══════════════════════════════════════════════════════════╗'
  cyan '║ Projeto : cursor-template                                ║'
  cyan "║ Versão  : $(printf '%-48s' "$VERSION") ║"
  cyan "║ Data    : $(printf '%-48s' "$(date '+%Y-%m-%d %H:%M')") ║"
  cyan "║ Função  : scaffold-repo ($(printf '%-37s' "$mode")) ║"
  cyan '╠══════════════════════════════════════════════════════════╣'
  cyan "║ Source  : $(printf '%-48s' "$src") ║"
  cyan "║ Target  : $(printf '%-48s' "$dst") ║"
  cyan '╚══════════════════════════════════════════════════════════╝'
  out ''
}

ask_yes_no() {
  local prompt="$1" default="${2:-0}"
  if [[ "$QUIET" -eq 1 || "$SSH" -eq 1 ]]; then
    [[ "$default" == "1" ]]
    return
  fi
  while true; do
    printf '%s\n' "$prompt"
    printf '  0 = não (default)\n'
    printf '  1 = sim\n'
    printf 'Escolha: '
    local raw=""
    read -r raw || true
    if [[ -z "$raw" ]]; then
      [[ "$default" == "1" ]]
      return
    fi
    if [[ "$raw" == "0" ]]; then return 1; fi
    if [[ "$raw" == "1" ]]; then return 0; fi
    out 'WARN: entrada inválida; digite 0 ou 1.'
  done
}

write_fresh_prompt_status() {
  local path="$1"
  cat >"$path" <<'EOF'
# .prompt-status
# Rastreamento mínimo de prompts do Cursor AI.
# Formato: chave = valor
#
current_prompt_number = 0
current_prompt_start_time = 1970-01-01T00:00:00Z
EOF
}

assert_source() {
  [[ -f "$SOURCE_ROOT/spec-project-bootstrap.md" ]] || die "FAIL: fonte inválida (falta spec-project-bootstrap.md em $SOURCE_ROOT)"
}

install_scaffold() {
  assert_source
  if [[ "$SSH" -eq 1 ]]; then
    [[ "$DEST_SET" -eq 1 ]] || die 'FAIL: --ssh exige --target'
    [[ -n "$LOG" ]] || die 'FAIL: --ssh exige --log'
  fi

  local src_real dst_real
  src_real="$(cd "$SOURCE_ROOT" && pwd)"
  mkdir -p "$TARGET_ROOT"
  dst_real="$(cd "$TARGET_ROOT" && pwd)"
  if [[ "$src_real" == "$dst_real" ]]; then
    die 'FAIL: destino não pode ser a própria pasta fonte do template. Use --target <nova-pasta>.'
  fi

  local count
  count="$(find "$TARGET_ROOT" -mindepth 1 -maxdepth 1 ! -name "$MANIFEST_NAME" | wc -l | tr -d ' ')"
  if [[ "$count" != "0" ]]; then
    if ! ask_yes_no 'Destino não está vazio. Sobrescrever arquivos da lista canônica?' 0; then
      if [[ "$QUIET" -eq 1 || "$SSH" -eq 1 ]]; then
        [[ "$FORCE" -eq 1 ]] || die 'FAIL: destino não vazio; use --force com --quiet/--ssh para sobrescrever'
      else
        out 'SKIP: abortado pelo operador.'
        return 0
      fi
    else
      if [[ ( "$QUIET" -eq 1 || "$SSH" -eq 1 ) && "$FORCE" -eq 0 ]]; then
        die 'FAIL: sobrescrita em modo quiet/ssh exige --force'
      fi
    fi
  fi

  local rel from to
  : >"$TARGET_ROOT/$MANIFEST_NAME.tmp"
  printf '%s\n' '# scaffold-manifest' '# paths relative to repo root' >"$TARGET_ROOT/$MANIFEST_NAME.tmp"
  for rel in "${FILE_LIST[@]}"; do
    from="$SOURCE_ROOT/$rel"
    to="$TARGET_ROOT/$rel"
    [[ -f "$from" ]] || die "FAIL: arquivo fonte ausente: $rel"
    mkdir -p "$(dirname "$to")"
    if [[ "$rel" == ".prompt-status" ]]; then
      write_fresh_prompt_status "$to"
    else
      cp -f "$from" "$to"
    fi
    printf '%s\n' "$rel" >>"$TARGET_ROOT/$MANIFEST_NAME.tmp"
    out "OK   file  $rel"
  done
  mv -f "$TARGET_ROOT/$MANIFEST_NAME.tmp" "$TARGET_ROOT/$MANIFEST_NAME"
  out "OK   file  $MANIFEST_NAME"
  out ''
  out 'OK: scaffold concluído. Próximo: personalizar via specs/optional/bootstrap-personalizar-projeto.md'
  out '     Validar: ./scripts/validation/validate-structure.sh'
}

uninstall_scaffold() {
  local manifest="$TARGET_ROOT/$MANIFEST_NAME"
  [[ -f "$manifest" ]] || die "FAIL: manifest não encontrado ($MANIFEST_NAME); nada a desinstalar com segurança"
  if [[ ( "$QUIET" -eq 1 || "$SSH" -eq 1 ) && "$FORCE" -eq 0 ]]; then
    die 'FAIL: --uninstall com --quiet/--ssh exige --force'
  fi
  if ! ask_yes_no 'Remover arquivos listados no manifest (somente o que o scaffold criou)?' 0; then
    if [[ ! ( ( "$QUIET" -eq 1 || "$SSH" -eq 1 ) && "$FORCE" -eq 1 ) ]]; then
      out 'SKIP: uninstall abortado.'
      return 0
    fi
  fi

  local rel
  # delete files reverse order
  mapfile -t lines < <(grep -v '^\s*#' "$manifest" | grep -v '^\s*$' | tac)
  for rel in "${lines[@]}"; do
    if [[ -f "$TARGET_ROOT/$rel" ]]; then
      rm -f "$TARGET_ROOT/$rel"
      out "OK   del   $rel"
    else
      out "SKIP missing $rel"
    fi
  done

  # best-effort empty dirs
  local d
  for rel in "${lines[@]}"; do
    d="$(dirname "$rel")"
    while [[ "$d" != "." && "$d" != "/" ]]; do
      if [[ -d "$TARGET_ROOT/$d" ]] && [[ -z "$(find "$TARGET_ROOT/$d" -mindepth 1 -maxdepth 1 2>/dev/null | head -n 1)" ]]; then
        rmdir "$TARGET_ROOT/$d" 2>/dev/null || true
        out "OK   rmdir $d"
      fi
      d="$(dirname "$d")"
    done
  done

  rm -f "$manifest"
  out "OK   del   $MANIFEST_NAME"

  # limpar pastas vazias restantes na raiz do destino
  if [[ -d "$TARGET_ROOT" ]]; then
    find "$TARGET_ROOT" -mindepth 1 -maxdepth 1 -type d -empty -delete 2>/dev/null || true
  fi

  out 'OK: uninstall concluído.'
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h) usage; exit 0 ;;
    --uninstall) MODE_UNINSTALL=1; shift ;;
    --quiet|-q) QUIET=1; shift ;;
    --force|-f) FORCE=1; shift ;;
    --ssh) SSH=1; shift ;;
    --log)
      LOG="${2:-}"; [[ -n "$LOG" ]] || die 'FAIL: --log exige caminho'
      shift 2
      ;;
    --target)
      TARGET_ROOT="${2:-}"; [[ -n "$TARGET_ROOT" ]] || die 'FAIL: --target exige caminho'
      DEST_SET=1
      shift 2
      ;;
    *) die "FAIL: argumento desconhecido: $1" ;;
  esac
done

if [[ -n "$LOG" ]]; then
  mkdir -p "$(dirname "$LOG")"
  : >"$LOG"
fi

if [[ "$MODE_UNINSTALL" -eq 1 ]]; then
  header uninstall
  uninstall_scaffold
else
  header install
  install_scaffold
fi
