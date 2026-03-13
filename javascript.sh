#!/usr/bin/env bash

[ -d "$HOME/nvim-macos/bin" ] && export PATH="$HOME/nvim-macos/bin:$PATH"
[ -d "/opt/nvim/bin" ] && export PATH="/opt/nvim/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "✅ Initialized JavaScript Environment"
