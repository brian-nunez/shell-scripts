#!/usr/bin/env bash

export PATH="$HOME/.local/bin:$PATH"

COLOR_DEF='\[\033[0m\]'
COLOR_USR='\[\033[38;5;243m\]'
COLOR_DIR='\[\033[38;5;197m\]'
COLOR_GIT='\[\033[38;5;39m\]'

parse_git_branch() {
  git branch 2>/dev/null | sed -n 's/^\* \(.*\)/[\1]/p'
}

parse_dir_name() {
  basename "$PWD"
}

PS1="${COLOR_USR}\u ${COLOR_DIR}\$(parse_dir_name) ${COLOR_GIT}\$(parse_git_branch)${COLOR_DIR} ${COLOR_DEF}\$ "

echo "✅ Initialized Shell Config (bash)"
