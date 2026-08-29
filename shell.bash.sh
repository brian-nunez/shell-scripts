#!/usr/bin/env bash

_shell_scripts_prepend_path "$HOME/.local/bin"

COLOR_DEF='\[\033[0m\]'
COLOR_USR='\[\033[38;5;243m\]'
COLOR_DIR='\[\033[38;5;197m\]'
COLOR_GIT='\[\033[38;5;39m\]'

parse_git_branch() {
  local branch

  branch=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null) || return 0
  printf '[%s]' "$branch"
}

parse_dir_name() {
  if [ "$PWD" = '/' ]; then
    printf '/'
  else
    printf '%s' "${PWD##*/}"
  fi
}

PS1="${COLOR_USR}\u ${COLOR_DIR}\$(parse_dir_name) ${COLOR_GIT}\$(parse_git_branch)${COLOR_DIR} ${COLOR_DEF}\$ "

echo "✅ Initialized Shell Config (bash)"
