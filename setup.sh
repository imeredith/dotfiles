#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

detect_os() {
  case "$(uname -s)" in
    Darwin)
      printf '%s\n' "mac"
      ;;
    Linux)
      printf '%s\n' "linux"
      ;;
    *)
      printf 'Unsupported OS: %s\n' "$(uname -s)" >&2
      exit 1
      ;;
  esac
}

backup_target() {
  local target=$1
  local backup

  backup="${target}.backup.$(date +%Y%m%d%H%M%S)"
  while [ -e "$backup" ] || [ -L "$backup" ]; do
    backup="${backup}.1"
  done

  mv "$target" "$backup"
  printf 'Backed up %s -> %s\n' "$target" "$backup"
}

link_tree() {
  local src_dir=$1
  local src
  local rel
  local target
  local target_dir

  [ -d "$src_dir" ] || return 0

  while IFS= read -r src; do

    rel=${src#"$src_dir"/}
    case "$rel" in
      .gitkeep|.DS_Store)
        continue
        ;;
    esac

    target="$HOME/$rel"
    target_dir=$(dirname "$target")
    mkdir -p "$target_dir"

    if [ -L "$target" ] && [ "$(readlink "$target")" = "$src" ]; then
      printf 'Unchanged %s\n' "$target"
      continue
    fi

    if [ -e "$target" ] || [ -L "$target" ]; then
      backup_target "$target"
    fi

    ln -s "$src" "$target"
    printf 'Linked %s -> %s\n' "$target" "$src"
  done < <(find "$src_dir" -type f | LC_ALL=C sort)
}

run_scripts() {
  local scripts_dir=$1
  local script

  [ -d "$scripts_dir" ] || return 0

  while IFS= read -r script; do
    [ -x "$script" ] || continue

    printf 'Running %s\n' "$script"
    "$script"
  done < <(find "$scripts_dir" -type f | LC_ALL=C sort)
}

main() {
  local os

  os=$(detect_os)

  link_tree "$SCRIPT_DIR/files/all"
  link_tree "$SCRIPT_DIR/files/$os"

  run_scripts "$SCRIPT_DIR/scripts/all"
  run_scripts "$SCRIPT_DIR/scripts/$os"
}

main "$@"
