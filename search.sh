#!/bin/bash

alias gtg="gotogit"

function goto() {
  local dir
  dir=$(find ~/Documents/workspace -path "*/node_modules/*" -prune -o -type d -print | fzf)
  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}

function gotogit() {
  searchDir="$HOME/Documents/workspace"
  if [ -n "$1" ]; then
    searchDir="$1"
  fi
  out=$(readlink -f "$searchDir")
  local dir
  dir=$(find "$out" -path "*/node_modules" -prune -o -type d -name ".git" -print | sed 's|/\.git||' | fzf)
  if [ -n "$dir" ]; then
    cd "$dir"
  fi
}

echo "✅ Initialized Search Helpers"
