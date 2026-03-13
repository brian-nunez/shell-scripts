#!/usr/bin/env bash

watch() {
  while true; do
    clear
    "$@"
    sleep 1
  done
}

echo "✅ Initialized Functions"

