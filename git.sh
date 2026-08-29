#!/usr/bin/env bash

gco() {
  local branch

  command -v fzf >/dev/null 2>&1 || return 127
  branch=$(command git for-each-ref --format='%(refname:short)' refs/heads | fzf) || return 0
  [ -n "$branch" ] && command git switch "$branch"
}

echo "✅ Initialized Git Helpers"
