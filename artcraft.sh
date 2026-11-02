#!/usr/bin/env bash

case "$(uname -s)" in
  Darwin)
    photocraft_path="$HOME/.local/share/photocraft-cli/photocraft-cli"
    deckcraft_path="$HOME/.local/bin/deckcraft-cli"
    figcraft_path="$HOME/.local/bin/figcraft-cli"
    gridcraft_path="$HOME/.local/bin/gridcraft-cli"
    pdfcraft_path="$HOME/.local/bin/pdfcraft-cli"
    wordcraft_path="$HOME/.local/bin/wordcraft-cli"

    [ -x "$photocraft_path" ] && alias photocraft="'$photocraft_path'"
    [ -x "$deckcraft_path" ] && alias deckcraft="'$deckcraft_path'"
    [ -x "$figcraft_path" ] && alias figcraft="'$figcraft_path'"
    [ -x "$gridcraft_path" ] && alias gridcraft="'$gridcraft_path'"
    [ -x "$pdfcraft_path" ] && alias pdfcraft="'$pdfcraft_path'"
    [ -x "$wordcraft_path" ] && alias wordcraft="'$wordcraft_path'"

    unset photocraft_path deckcraft_path figcraft_path gridcraft_path
    unset pdfcraft_path wordcraft_path
    ;;
  Linux)
    # Add Linux-specific Artcraft paths and aliases here when supported.
    ;;
esac
