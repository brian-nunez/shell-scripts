#!/usr/bin/env bash

if [ -x "/opt/homebrew/bin/brew" ]; then
  case ":$PATH:" in
    *:/opt/homebrew/bin:*) ;;
    *) eval "$(/opt/homebrew/bin/brew shellenv)" ;;
  esac
fi

echo "✅ Initialized Brew"
