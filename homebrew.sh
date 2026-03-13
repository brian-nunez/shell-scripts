#!/usr/bin/env bash

if [ -x "/opt/homebrew/bin/brew" ]; then
  # loads homebrew
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "✅ Initialized Brew"
