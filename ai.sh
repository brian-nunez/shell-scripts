#!/usr/bin/env bash

export GEMINI_SANDBOX=true
if [ -d "$HOME/.lmstudio/bin" ]; then
  _shell_scripts_prepend_path "$HOME/.lmstudio/bin"
fi

echo "✅ Initialized AI"
