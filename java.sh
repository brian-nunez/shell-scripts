#!/usr/bin/env bash

[ -d "/usr/libexec/java_home" ] && export JAVA_HOME="$(/usr/libexec/java_home -v 21)"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"

echo "✅ Initialized JavaScript Environment"

