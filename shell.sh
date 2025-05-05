#!/bin/bash

export COLOR_DEF='%f'
export COLOR_USR='%F{243}'
export COLOR_DIR='%F{197}'
export COLOR_GIT='%F{39}'
export NEW_LINE=$'\n'

# Gets the current branch
function parse_git_branch() {
  git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

# Gets the current folder name
function parse_dir_name() {
  basename "${PWD}"
}


setopt PROMPT_SUBST
export PROMPT='${COLOR_USR}%n ${COLOR_DIR}$(parse_dir_name) ${COLOR_GIT}$(parse_git_branch)${COLOR_DIR} ${COLOR_DEF}$ '

echo "✅ Initialized Shell Config"
