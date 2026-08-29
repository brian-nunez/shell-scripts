#!/usr/bin/env bash

if [ -n "${ZSH_VERSION:-}" ]; then
  if [ -d "$HOME/.docker/completions" ]; then
    case ":${FPATH:-}:" in
      *":$HOME/.docker/completions:"*) ;;
      *) FPATH="$HOME/.docker/completions${FPATH:+:$FPATH}" ;;
    esac
  fi

  if ! whence -w _complete >/dev/null 2>&1; then
    autoload -Uz compinit
    compinit -C
  fi
elif [ -n "${BASH_VERSION:-}" ] && [ -z "${SHELL_SCRIPTS_DOCKER_COMPLETION_LOADED:-}" ]; then
  if command -v docker >/dev/null 2>&1 && ! complete -p docker >/dev/null 2>&1; then
    . <(docker completion bash 2>/dev/null)
  fi

  SHELL_SCRIPTS_DOCKER_COMPLETION_LOADED=1
fi

echo "✅ Initialized Docker"
