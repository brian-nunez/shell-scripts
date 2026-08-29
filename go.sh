#!/usr/bin/env bash

[ -d "$HOME/go/bin" ] && _shell_scripts_prepend_path "$HOME/go/bin"

# Go Helpers
alias air='$(go env GOPATH)/bin/air'

echo "✅ Initialized Go Environment"
