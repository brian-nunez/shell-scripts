#!/usr/bin/env bash

if [ "$(uname -s)" = "Darwin" ]; then
  if [ -x "/usr/libexec/java_home" ]; then
    java_home=$(/usr/libexec/java_home -v 21 2>/dev/null) || java_home=''
    [ -n "$java_home" ] && export JAVA_HOME="$java_home"
    unset java_home
  fi

  [ -d "/opt/homebrew/opt/openjdk@21/bin" ] && _shell_scripts_prepend_path "/opt/homebrew/opt/openjdk@21/bin"

  if [ -d "/opt/homebrew/opt/openjdk@21/include" ]; then
    case " ${CPPFLAGS:-} " in
      *' -I/opt/homebrew/opt/openjdk@21/include '*) ;;
      *) CPPFLAGS="${CPPFLAGS:+$CPPFLAGS }-I/opt/homebrew/opt/openjdk@21/include" ;;
    esac
    export CPPFLAGS
  fi
fi

echo "✅ Initialized Java Environment"
