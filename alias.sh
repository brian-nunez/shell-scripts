#!/usr/bin/env bash

if [ -n "${ZSH_VERSION:-}" ]; then
  alias s='source "$HOME/.zshrc"'
elif [ -n "${BASH_VERSION:-}" ]; then
  alias s='source "$HOME/.bashrc"'
fi

# Use NeoVim with short-hand alias
alias vim='nvim'

if [ "$(uname -s)" = "Darwin" ] && [ -f "/Applications/Tailscale.app/Contents/MacOS/Tailscale" ]; then
  alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
fi

echo "✅ Initialized Aliases"
