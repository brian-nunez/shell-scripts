#!/bin/bash

export PATH_TO_SCRIPTS=~/shell-scripts

echo "🔌 Initializing environment..."

source $PATH_TO_SCRIPTS/javascript.sh
source $PATH_TO_SCRIPTS/ai.sh
source $PATH_TO_SCRIPTS/java.sh
source $PATH_TO_SCRIPTS/shell.sh
source $PATH_TO_SCRIPTS/tmux.sh
source $PATH_TO_SCRIPTS/homebrew.sh
source $PATH_TO_SCRIPTS/alias.sh
source $PATH_TO_SCRIPTS/search.sh
source $PATH_TO_SCRIPTS/git.sh
source $PATH_TO_SCRIPTS/functions.sh
source $PATH_TO_SCRIPTS/arduino.sh

echo "🛠️ Loaded Scripts"
