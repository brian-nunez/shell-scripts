#!/usr/bin/env bash

_shell_scripts_prepend_path "$HOME/.local/bin"

COLOR_DEF='%f'
COLOR_USR='%F{243}'
COLOR_DIR='%F{197}'
COLOR_GIT='%F{39}'

# Gets the current branch
parse_git_branch() {
  local branch

  branch=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null) || return 0
  printf '[%s]' "$branch"
}

# Gets the current folder name
parse_dir_name() {
  if [ "$PWD" = '/' ]; then
    printf '/'
  else
    printf '%s' "${PWD##*/}"
  fi
}

setopt PROMPT_SUBST
PROMPT='${COLOR_USR}%n ${COLOR_DIR}$(parse_dir_name) ${COLOR_GIT}$(parse_git_branch)${COLOR_DIR} ${COLOR_DEF}$ '

echo "✅ Initialized Shell Config (zsh)"
