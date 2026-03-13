#!/usr/bin/env bash

export PATH_TO_SCRIPTS=~/shell-scripts

echo "🔌 Initializing environment..."

for script in \
  javascript.sh \
  ai.sh \
  java.sh \
  shell.sh \
  tmux.sh \
  homebrew.sh \
  alias.sh \
  search.sh \
  git.sh \
  functions.sh \
  arduino.sh
do
  file="$PATH_TO_SCRIPTS/$script"

  [ -f "$file" ] && . "$file"
done

echo "🛠️ Loaded Scripts"
