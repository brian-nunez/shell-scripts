#!/usr/bin/env bash

if command -v rbenv >/dev/null 2>&1 && [ -z "${SHELL_SCRIPTS_RBENV_INITIALIZED:-}" ]; then
  if [ -n "${ZSH_VERSION:-}" ]; then
    eval "$(rbenv init - zsh)"
  elif [ -n "${BASH_VERSION:-}" ]; then
    eval "$(rbenv init - bash)"
  fi

  SHELL_SCRIPTS_RBENV_INITIALIZED=1
fi

echo "✅ Initialized Ruby"
