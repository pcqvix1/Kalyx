#!/usr/bin/env bash

set -Eeuo pipefail

if [[ -n "${KALYX_COMMON_LOADED:-}" ]]; then
  return 0
fi
KALYX_COMMON_LOADED=1

kalyx_script_dir() {
  local source="${BASH_SOURCE[0]}"
  while [[ -L "$source" ]]; do
    local dir
    dir="$(cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd)"
    source="$(readlink "$source")"
    [[ "$source" != /* ]] && source="$dir/$source"
  done
  cd -P "$(dirname "$source")" >/dev/null 2>&1 && pwd
}

kalyx_root() {
  if [[ -n "${KALYX_REPO:-}" ]]; then
    printf '%s\n' "$KALYX_REPO"
    return
  fi

  local dir
  dir="$(kalyx_script_dir)"
  cd "$dir/../.." >/dev/null 2>&1 && pwd
}

KALYX_REPO="$(kalyx_root)"

# shellcheck source=/dev/null
source "$KALYX_REPO/config/kalyx.conf"

info() {
  printf '[INFO] %s\n' "$*"
}

warn() {
  printf '[WARN] %s\n' "$*" >&2
}

die() {
  printf '[ERRO] %s\n' "$*" >&2
  exit 1
}

require_cmd() {
  local missing=0
  local cmd
  for cmd in "$@"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      warn "Comando ausente: $cmd"
      missing=1
    fi
  done
  [[ "$missing" -eq 0 ]] || die "Instale os comandos ausentes e rode novamente."
}

require_linux() {
  [[ "$(uname -s)" == "Linux" ]] || die "Este script deve rodar dentro do Ubuntu/Linux da VM."
}

is_wsl() {
  grep -qiE 'microsoft|wsl' /proc/version 2>/dev/null
}

path_is_windows_mount() {
  local path="$1"
  [[ "$path" == /mnt/[a-zA-Z]* || "$path" == /media/sf_* ]]
}

ensure_linux_build_path() {
  local path="$1"
  if path_is_windows_mount "$path"; then
    die "Nao use '$path' para build LFS. Use uma pasta Linux/ext4 dentro da VM, como $HOME/kalyx-work."
  fi
}

ensure_dirs() {
  mkdir -p "$KALYX_WORKDIR" "$KALYX_SOURCES" "$KALYX_BUILD" "$KALYX_ROOTFS" \
    "$KALYX_PACKAGES" "$KALYX_ISO" "$KALYX_LOGDIR"
}

free_gb_for_path() {
  local path="$1"
  mkdir -p "$path"
  df -P -BG "$path" | awk 'NR==2 { gsub(/G/, "", $4); print $4 }'
}

run_logged() {
  local name="$1"
  shift
  mkdir -p "$KALYX_LOGDIR"
  local log="$KALYX_LOGDIR/$name.log"
  info "Rodando: $*"
  info "Log: $log"
  "$@" 2>&1 | tee "$log"
}

download_to() {
  local url="$1"
  local dest="$2"
  mkdir -p "$(dirname "$dest")"

  if command -v wget >/dev/null 2>&1; then
    wget --continue --output-document="$dest" "$url"
  elif command -v curl >/dev/null 2>&1; then
    curl --fail --location --continue-at - --output "$dest" "$url"
  else
    die "Instale wget ou curl."
  fi
}

strip_archive_name() {
  local archive="$1"
  archive="${archive##*/}"
  archive="${archive%.tar.gz}"
  archive="${archive%.tar.xz}"
  archive="${archive%.tar.bz2}"
  archive="${archive%.tar.zst}"
  archive="${archive%.tgz}"
  archive="${archive%.zip}"
  printf '%s\n' "$archive"
}

