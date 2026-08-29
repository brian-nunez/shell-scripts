#!/usr/bin/env bash

if [ -n "${ZSH_VERSION:-}" ]; then
  [ -f "$SHELL_SCRIPTS_DIR/shell.zsh.sh" ] && . "$SHELL_SCRIPTS_DIR/shell.zsh.sh"
elif [ -n "${BASH_VERSION:-}" ]; then
  [ -f "$SHELL_SCRIPTS_DIR/shell.bash.sh" ] && . "$SHELL_SCRIPTS_DIR/shell.bash.sh"
fi
