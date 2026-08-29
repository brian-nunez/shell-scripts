#!/usr/bin/env bash

if [ -x "/opt/homebrew/bin/brew" ]; then
  # loads homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

[[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && . "$(brew --prefix)/etc/profile.d/bash_completion.sh"

echo "✅ Initialized Brew"
