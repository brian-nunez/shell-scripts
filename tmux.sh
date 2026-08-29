#!/usr/bin/env bash

if [ -n "${TMUX:-}" ] && [ -r "$HOME/.config/tmux/.tmux.config" ]; then
  tmux source-file "$HOME/.config/tmux/.tmux.config"
fi

echo "✅ Initialized Tmux"
