#!/usr/bin/env bash

SHELL_SCRIPTS_DIR="$HOME/shell-scripts"

_shell_scripts_prepend_path() {
  [ -n "$1" ] || return 0

  case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1${PATH:+:$PATH}" ;;
  esac

  export PATH
}

echo "🔌 Initializing environment..."

for shell_scripts_name in \
  homebrew.sh \
  shell.sh \
  javascript.sh \
  ai.sh \
  java.sh \
  go.sh \
  ruby.sh \
  arduino.sh \
  docker.sh \
  tmux.sh \
  functions.sh \
  search.sh \
  git.sh \
  alias.sh \
  secrets.sh
do
  shell_scripts_file="$SHELL_SCRIPTS_DIR/$shell_scripts_name"
  [ -f "$shell_scripts_file" ] && . "$shell_scripts_file"
done

unset shell_scripts_file shell_scripts_name SHELL_SCRIPTS_DIR
unset -f _shell_scripts_prepend_path 2>/dev/null || true

echo "🛠️ Loaded Scripts"
