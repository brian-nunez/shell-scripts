#!/usr/bin/env bash

case "$(uname -s)" in
  Darwin)
    ghidra_path="$HOME/Applications/ghidra_12.1.4_PUBLIC/ghidraRun"
    if [ -x "$ghidra_path" ]; then
      alias ghidra="'$ghidra_path'"
    fi
    ;;
  Linux)
    # Add Linux-specific Ghidra paths and aliases here when supported.
    ;;
esac

unset ghidra_path
