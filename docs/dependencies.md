# Dependencies and Installation

## Validation

```bash
cd "$HOME/shell-scripts"
./validate.sh
```

The checker detects macOS ARM64, Ubuntu Desktop 24 AMD64, or Omarchy x86_64. Missing required tools include an installation command. Tailscale is optional.

## Core Tools

| Tool | macOS ARM64 | Ubuntu Desktop 24 AMD64 | Omarchy x86_64 |
| --- | --- | --- | --- |
| Git | `xcode-select --install` | `sudo apt-get update && sudo apt-get install -y git` | `sudo pacman -Syu --needed git` |
| Go | `brew install go` | `sudo apt-get update && sudo apt-get install -y golang-go` | `sudo pacman -Syu --needed go` |
| Java 21 | `brew install openjdk@21` | `sudo apt-get update && sudo apt-get install -y openjdk-21-jdk` | `sudo pacman -Syu --needed jdk21-openjdk` |
| Node.js and npm | `brew install node` | `sudo apt-get update && sudo apt-get install -y nodejs npm` | `sudo pacman -Syu --needed nodejs npm` |
| Docker | `brew install --cask docker` | `sudo apt-get update && sudo apt-get install -y docker.io docker-buildx` | `sudo pacman -Syu --needed docker docker-buildx` |
| rbenv | `brew install rbenv` | `sudo apt-get update && sudo apt-get install -y rbenv` | `sudo pacman -Syu --needed rbenv` |
| fzf | `brew install fzf` | `sudo apt-get update && sudo apt-get install -y fzf` | `sudo pacman -Syu --needed fzf` |
| tmux | `brew install tmux` | `sudo apt-get update && sudo apt-get install -y tmux` | `sudo pacman -Syu --needed tmux` |
| Arduino CLI | `brew install arduino-cli` | `curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh \| BINDIR="$HOME/.local/bin" sh -s 1.5.1` | `sudo pacman -Syu --needed arduino-cli` |

## Neovim 0.11 or Newer

- macOS ARM64: `brew install neovim`
- Omarchy x86_64: `sudo pacman -Syu --needed neovim`
- Ubuntu Desktop 24 AMD64:

```bash
archive="$(mktemp)"
mkdir -p "$HOME/.local/opt" "$HOME/.local/bin"
curl -fL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -o "$archive"
tar -xzf "$archive" -C "$HOME/.local/opt"
ln -sfn "$HOME/.local/opt/nvim-linux-x86_64/bin/nvim" "$HOME/.local/bin/nvim"
rm -f "$archive"
```

## Arduino Uno R4 WiFi

Initialize Arduino CLI and install the board core:

```bash
arduino-cli config init
arduino-cli core update-index
arduino-cli core install arduino:renesas_uno
```

## Optional Tools

- NVM is loaded automatically from `$HOME/.nvm/nvm.sh` when installed.
- Tailscale installation:
  - macOS: install the Tailscale application from the Mac App Store.
  - Ubuntu: `curl -fsSL https://tailscale.com/install.sh | sh`
  - Omarchy: `sudo pacman -Syu --needed tailscale`
