#!/bin/bash

# change git branch with fzf
function gco() {
  git branch | fzf | xargs git co
}

echo "✅ Initialized Git Helpers"
