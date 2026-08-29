# Shell Scripts

Fast, modular shell configuration for:

- macOS ARM64 with Zsh
- Ubuntu Desktop 24 AMD64 with Bash
- Omarchy x86_64 with Bash

## Install

Clone the repository to `~/shell-scripts`, then source its entry point from the appropriate shell configuration:

```bash
# ~/.zshrc or ~/.bashrc
source "$HOME/shell-scripts/init.sh"
```

Run the dependency checker before opening a new terminal:

```bash
cd "$HOME/shell-scripts"
./validate.sh
```

The checker verifies:

- Git
- Go
- Java 21
- Node.js and npm
- Neovim 0.11 or newer
- Docker
- rbenv
- fzf
- tmux
- Arduino CLI, its configuration, and the Arduino Uno R4 core
- Homebrew on macOS
- Tailscale when installed

NVM is optional. When `$HOME/.nvm/nvm.sh` exists, it is loaded automatically.

## Included Features

- Bash and Zsh prompts with the current Git branch
- Idempotent PATH setup for `~/.local/bin`, Go, Java, and optional tools
- NVM, rbenv, Docker completion, tmux, Arduino, and AI tool initialization
- Fuzzy directory, repository, and Git branch navigation with fzf
- `vim` mapped to Neovim
- Platform-aware Tailscale integration

## Documentation

- [Architecture](docs/architecture.md)
- [Dependencies](docs/dependencies.md)
- [Tools and aliases](docs/tools.md)

## Local Secrets

`secrets.sh` is loaded when present and is excluded by `.gitignore`. It is intentionally user-managed and must never be committed.
