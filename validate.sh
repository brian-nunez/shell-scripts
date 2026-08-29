#!/usr/bin/env bash

set -u
set -o pipefail

required_missing=0
optional_missing=0

if [[ -t 1 && -z "${NO_COLOR:-}" ]]; then
  readonly GREEN=$'\033[32m'
  readonly YELLOW=$'\033[33m'
  readonly RED=$'\033[31m'
  readonly BOLD=$'\033[1m'
  readonly RESET=$'\033[0m'
else
  readonly GREEN=''
  readonly YELLOW=''
  readonly RED=''
  readonly BOLD=''
  readonly RESET=''
fi

print_header() {
  printf '\n%s%s%s\n' "$BOLD" "$1" "$RESET"
}

print_install() {
  printf '  %sInstall:%s %s\n' "$YELLOW" "$RESET" "$1"
}

check_required() {
  local executable=$1
  local label=$2
  local install_command=$3
  local resolved_path

  resolved_path=$(command -v "$executable" 2>/dev/null || true)
  if [[ -n "$resolved_path" ]]; then
    printf '%s[ok]%s %-28s %s\n' "$GREEN" "$RESET" "$label" "$resolved_path"
    return 0
  fi

  printf '%s[missing]%s %s is required.\n' "$RED" "$RESET" "$label"
  print_install "$install_command"
  required_missing=$((required_missing + 1))
  return 1
}

version_at_least() {
  awk -v current="$1" -v required="$2" 'BEGIN {
    split(current, current_parts, ".")
    split(required, required_parts, ".")
    for (part_index = 1; part_index <= 3; part_index++) {
      current_part = current_parts[part_index] + 0
      required_part = required_parts[part_index] + 0
      if (current_part > required_part) exit 0
      if (current_part < required_part) exit 1
    }
    exit 0
  }'
}

check_java_21() {
  local install_command=$1
  local resolved_path version major

  resolved_path=$(command -v java 2>/dev/null || true)
  if [[ -n "$resolved_path" ]]; then
    version=$(java -version 2>&1 | awk -F '"' 'NR == 1 { print $2 }')
    major=${version%%.*}
    if [[ "$major" == '1' ]]; then
      version=${version#*.}
      major=${version%%.*}
    fi

    if [[ "$major" == '21' ]]; then
      printf '%s[ok]%s %-28s %s (%s)\n' "$GREEN" "$RESET" 'Java (OpenJDK 21)' "$resolved_path" "$version"
      return 0
    fi
  fi

  printf '%s[missing]%s Java 21 is required.\n' "$RED" "$RESET"
  print_install "$install_command"
  required_missing=$((required_missing + 1))
  return 1
}

check_neovim() {
  local install_command=$1
  local resolved_path version

  resolved_path=$(command -v nvim 2>/dev/null || true)
  if [[ -n "$resolved_path" ]]; then
    version=$(nvim --version 2>/dev/null | awk 'NR == 1 { sub(/^v/, "", $2); print $2 }')
    if [[ -n "$version" ]] && version_at_least "$version" '0.11.0'; then
      printf '%s[ok]%s %-28s %s (%s)\n' "$GREEN" "$RESET" 'Neovim 0.11+' "$resolved_path" "$version"
      return 0
    fi
  fi

  printf '%s[missing]%s Neovim 0.11 or newer is required.\n' "$RED" "$RESET"
  print_install "$install_command"
  required_missing=$((required_missing + 1))
  return 1
}

check_arduino_environment() {
  local config_path

  command -v arduino-cli >/dev/null 2>&1 || return 0

  if [[ "$platform" == 'macos-arm64' ]]; then
    config_path="$HOME/Library/Arduino15/arduino-cli.yaml"
  else
    config_path="$HOME/.arduino15/arduino-cli.yaml"
  fi

  if [[ -r "$config_path" ]]; then
    printf '%s[ok]%s %-28s %s\n' "$GREEN" "$RESET" 'Arduino CLI configuration' "$config_path"
  else
    printf '%s[missing]%s Arduino CLI configuration is required.\n' "$RED" "$RESET"
    print_install 'arduino-cli config init'
    required_missing=$((required_missing + 1))
  fi

  if arduino-cli core list 2>/dev/null | awk 'NR > 1 && $1 == "arduino:renesas_uno" { found=1 } END { exit !found }'; then
    printf '%s[ok]%s %-28s %s\n' "$GREEN" "$RESET" 'Arduino Uno R4 core' 'arduino:renesas_uno'
  else
    printf '%s[missing]%s The Arduino Uno R4 core is required.\n' "$RED" "$RESET"
    print_install 'arduino-cli core update-index && arduino-cli core install arduino:renesas_uno'
    required_missing=$((required_missing + 1))
  fi
}

check_optional() {
  local executable=$1
  local label=$2
  local install_command=$3
  local resolved_path

  resolved_path=$(command -v "$executable" 2>/dev/null || true)
  if [[ -n "$resolved_path" ]]; then
    printf '%s[ok]%s %-28s %s\n' "$GREEN" "$RESET" "$label" "$resolved_path"
    return 0
  fi

  printf '%s[optional]%s %s is not installed.\n' "$YELLOW" "$RESET" "$label"
  print_install "$install_command"
  optional_missing=$((optional_missing + 1))
  return 0
}

check_optional_macos_app() {
  local app_name=$1
  local label=$2
  local install_command=$3
  local system_path="/Applications/$app_name.app"
  local user_path="$HOME/Applications/$app_name.app"

  if [[ -d "$system_path" ]]; then
    printf '%s[ok]%s %-28s %s\n' "$GREEN" "$RESET" "$label" "$system_path"
    return
  fi

  if [[ -d "$user_path" ]]; then
    printf '%s[ok]%s %-28s %s\n' "$GREEN" "$RESET" "$label" "$user_path"
    return
  fi

  printf '%s[optional]%s %s is not installed.\n' "$YELLOW" "$RESET" "$label"
  print_install "$install_command"
  optional_missing=$((optional_missing + 1))
}

is_omarchy() {
  [[ "${ID:-}" == 'omarchy' ]] || {
    [[ "${ID:-}" == 'arch' ]] &&
      [[ -d /usr/share/omarchy || -d "$HOME/.local/share/omarchy" || -d "$HOME/.config/omarchy" ]]
  }
}

detect_platform() {
  local kernel architecture

  kernel=$(uname -s)
  architecture=$(uname -m)

  case "$kernel:$architecture" in
    Darwin:arm64)
      platform='macos-arm64'
      platform_name='macOS ARM64'
      ;;
    Linux:x86_64)
      if [[ -r /etc/os-release ]]; then
        # shellcheck disable=SC1091
        source /etc/os-release
      fi
      if is_omarchy; then
        platform='omarchy-x86_64'
        platform_name='Omarchy x86_64'
      elif [[ "${ID:-}" == 'ubuntu' && "${VERSION_ID:-}" == 24.* ]]; then
        platform='ubuntu24-amd64'
        platform_name="${PRETTY_NAME:-Ubuntu 24} AMD64"
      else
        printf '%s[unsupported]%s Supported Linux platforms are Ubuntu Desktop 24 AMD64 and Omarchy x86_64; detected %s %s.\n' "$RED" "$RESET" "${PRETTY_NAME:-Linux}" "$architecture"
        exit 2
      fi
      ;;
    *)
      printf '%s[unsupported]%s Supported platforms are macOS ARM64, Ubuntu Desktop 24 AMD64, and Omarchy x86_64; detected %s %s.\n' "$RED" "$RESET" "$kernel" "$architecture"
      exit 2
      ;;
  esac
}

check_macos() {
  print_header 'macOS Dependencies'
  check_required brew 'Homebrew' 'Install Homebrew from https://brew.sh' || true
  check_required git 'Git' 'xcode-select --install' || true
  check_required go 'Go' 'brew install go' || true
  check_java_21 'brew install openjdk@21' || true
  check_required node 'Node.js' 'brew install node' || true
  check_required npm 'npm' 'brew install node' || true
  check_neovim 'brew install neovim' || true
  check_required docker 'Docker' 'brew install --cask docker' || true
  check_required rbenv 'rbenv' 'brew install rbenv' || true
  check_required fzf 'fzf' 'brew install fzf' || true
  check_required tmux 'tmux' 'brew install tmux' || true
  check_required arduino-cli 'Arduino CLI' 'brew install arduino-cli' || true
  check_optional_macos_app 'Tailscale' 'Tailscale' 'Download Tailscale from the Mac App Store' || true
  check_arduino_environment
}

check_ubuntu() {
  print_header 'Ubuntu 24 Dependencies'
  check_required git 'Git' 'sudo apt-get update && sudo apt-get install -y git' || true
  check_required go 'Go' 'sudo apt-get update && sudo apt-get install -y golang-go' || true
  check_java_21 'sudo apt-get update && sudo apt-get install -y openjdk-21-jdk' || true
  check_required node 'Node.js' 'sudo apt-get update && sudo apt-get install -y nodejs npm' || true
  check_required npm 'npm' 'sudo apt-get update && sudo apt-get install -y nodejs npm' || true
  check_required docker 'Docker' 'sudo apt-get update && sudo apt-get install -y docker.io docker-buildx' || true
  check_neovim 'archive="$(mktemp)" && mkdir -p "$HOME/.local/opt" "$HOME/.local/bin" && curl -fL https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz -o "$archive" && tar -xzf "$archive" -C "$HOME/.local/opt" && ln -sfn "$HOME/.local/opt/nvim-linux-x86_64/bin/nvim" "$HOME/.local/bin/nvim" && rm -f "$archive"' || true
  check_required rbenv 'rbenv' 'sudo apt-get update && sudo apt-get install -y rbenv' || true
  check_required fzf 'fzf' 'sudo apt-get update && sudo apt-get install -y fzf' || true
  check_required tmux 'tmux' 'sudo apt-get update && sudo apt-get install -y tmux' || true
  check_required arduino-cli 'Arduino CLI' 'curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | BINDIR="$HOME/.local/bin" sh -s 1.5.1' || true
  check_optional tailscale 'Tailscale' 'curl -fsSL https://tailscale.com/install.sh | sh' || true
  check_arduino_environment
}

check_omarchy() {
  print_header 'Omarchy (Arch) Dependencies'
  check_required pacman 'pacman' 'Repair the base system before continuing' || true
  check_required git 'Git' 'sudo pacman -Syu --needed git' || true
  check_required go 'Go' 'sudo pacman -Syu --needed go' || true
  check_java_21 'sudo pacman -Syu --needed jdk21-openjdk' || true
  check_required node 'Node.js' 'sudo pacman -Syu --needed nodejs npm' || true
  check_required npm 'npm' 'sudo pacman -Syu --needed nodejs npm' || true
  check_required docker 'Docker' 'sudo pacman -Syu --needed docker docker-buildx' || true
  check_neovim 'sudo pacman -Syu --needed neovim' || true
  check_required rbenv 'rbenv' 'sudo pacman -Syu --needed rbenv' || true
  check_required fzf 'fzf' 'sudo pacman -Syu --needed fzf' || true
  check_required tmux 'tmux' 'sudo pacman -Syu --needed tmux' || true
  check_required arduino-cli 'Arduino CLI' 'sudo pacman -Syu --needed arduino-cli' || true
  check_optional tailscale 'Tailscale' 'sudo pacman -Syu --needed tailscale' || true
  check_arduino_environment
}

detect_platform
printf '%sShell Scripts Dependency Check%s\n' "$BOLD" "$RESET"
printf 'Platform: %s\n' "$platform_name"

case "$platform" in
  macos-arm64) check_macos ;;
  ubuntu24-amd64) check_ubuntu ;;
  omarchy-x86_64) check_omarchy ;;
esac

print_header 'Summary'
if (( required_missing == 0 )); then
  printf '%sAll required dependencies are installed.%s\n' "$GREEN" "$RESET"
else
  printf '%s%d required dependency check(s) failed.%s\n' "$RED" "$required_missing" "$RESET"
fi

if (( optional_missing > 0 )); then
  printf '%d optional tool(s) are not installed.\n' "$optional_missing"
fi

exit "$required_missing"
