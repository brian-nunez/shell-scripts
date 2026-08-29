#!/usr/bin/env bash

export NVM_DIR="$HOME/.nvm"
if ! command -v nvm >/dev/null 2>&1 && [ -s "$NVM_DIR/nvm.sh" ]; then
  . "$NVM_DIR/nvm.sh"

  if [ -n "${BASH_VERSION:-}" ] && [ -s "$NVM_DIR/bash_completion" ]; then
    . "$NVM_DIR/bash_completion"
  fi
fi

echo "✅ Initialized JavaScript Environment"
