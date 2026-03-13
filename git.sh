#!/usr/bin/env bash

# change git branch with fzf
function gco() {
  git branch | fzf | xargs git checkout
}

echo "✅ Initialized Git Helpers"
