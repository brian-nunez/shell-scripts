#!/bin/bash

# Displays my current IP address for easy access
alias ip="echo $(ifconfig | grep broadcast | awk '{print $2}')"

# Source .zshrc file in current terminal
alias s="source ~/.zshrc"

# Use NeoVim with short-hand alias
alias vim="nvim"

# Go Helpers
alias air='$(go env GOPATH)/bin/air'

echo "✅ Initialized Aliases"
