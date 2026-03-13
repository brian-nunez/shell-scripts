#!/usr/bin/env bash

[ -d "$HOME/nvim-macos/bin" ] && export PATH="/Users/briannunez/nvim-macos/bin/:$PATH"
[ -d "$HOME/nvim-linux-x86_64/bin" ] && export PATH="$HOME/nvim-linux-x86_64/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

echo "✅ Initialized JavaScript Environment"
