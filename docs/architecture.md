# Architecture and Design

## Supported Environments

- macOS ARM64 using Zsh
- Ubuntu Desktop 24 AMD64 using Bash
- Omarchy x86_64 using Bash

## Initialization

`init.sh` is the only entry point. Source it from `~/.zshrc` or `~/.bashrc`:

```bash
source "$HOME/shell-scripts/init.sh"
```

Scripts load in a fixed order:

1. Homebrew environment
2. Active shell configuration and prompt
3. JavaScript, AI, Java, Go, Ruby, Arduino, Docker, and tmux
4. General functions, search helpers, Git helpers, and aliases
5. Local secrets when `secrets.sh` exists

The explicit list prevents helper files, validation scripts, and future files from being sourced accidentally.

## Shell Detection

Shell-specific behavior uses `ZSH_VERSION` and `BASH_VERSION`. The `SHELL` environment variable is not used because it identifies the login shell and may not match the currently running interpreter.

## PATH Handling

`init.sh` provides a temporary idempotent PATH helper. Re-sourcing the configuration does not duplicate entries. Optional, tool-specific directories are only added when they exist; `~/.local/bin` is always available for user-managed executables.

The helper and loop variables are removed after initialization so they do not pollute the interactive shell.

## Startup Performance

- The prompt requests only the current symbolic Git branch.
- Docker completion is initialized at most once per shell session.
- Zsh uses its completion cache through `compinit -C`.
- Homebrew initialization is skipped when its binary directory is already present in PATH.

## Platform Boundaries

Operating-system checks are reserved for paths that truly differ by platform, including Homebrew, macOS Java discovery, application bundles, and Arduino configuration locations.

## Local Secrets

`secrets.sh` is optional, loaded last, and ignored by Git. Its contents and permissions are controlled by the user.
