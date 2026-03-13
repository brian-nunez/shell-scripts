#!/usr/bin/env bash

CURRENT_SHELL="${SHELL##*/}"

case "$CURRENT_SHELL" in
  zsh)
    [ -f "$HOME/shell-scripts/shell.zsh.sh" ] && . "$HOME/shell-scripts/shell.zsh.sh"
    ;;
  bash)
    [ -f "$HOME/shell-scripts/shell.bash.sh" ] && . "$HOME/shell-scripts/shell.bash.sh"
    ;;
esac

