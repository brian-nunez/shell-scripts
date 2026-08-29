#!/usr/bin/env bash

FPATH="$HOME/.docker/completions:$FPATH"
autoload -Uz compinit
compinit

echo "✅ Initialized Docker"

