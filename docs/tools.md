# Tools, Functions, and Aliases

## Functions

- `watch <command>` clears the terminal and reruns a command every second.
- `goto` uses fzf to navigate to any directory under `~/Documents/workspace`, excluding `node_modules` contents.
- `gotogit [directory]` uses fzf to navigate to a Git repository. It searches `~/Documents/workspace` by default.
- `gco` uses fzf to select a local Git branch and changes branches with `git switch`.

## Aliases

- `s` reloads `~/.zshrc` from Zsh or `~/.bashrc` from Bash.
- `vim` launches Neovim.
- `gtg` calls `gotogit`.
- `air` launches the Go Air executable from the active GOPATH.
- `tailscale` launches the macOS application binary when the App Store application is installed.

## Tool Initialization

- Homebrew configures its environment once on macOS ARM64.
- NVM loads when `$HOME/.nvm/nvm.sh` exists. Its Bash completion is loaded only by Bash.
- Java uses `/usr/libexec/java_home -v 21` on macOS and supports Homebrew OpenJDK 21.
- Go adds `$HOME/go/bin` when the directory exists.
- rbenv initializes for the active Bash or Zsh interpreter.
- Docker adds Docker Desktop Zsh completions and initializes Bash completion once per shell.
- tmux reloads `~/.config/tmux/.tmux.config` only inside tmux and only when the file exists.
- Arduino relies on `arduino-cli` from the system PATH.
- LM Studio adds `$HOME/.lmstudio/bin` when installed.
