#!/usr/bin/env bash
set -euo pipefail

echolog() {
  echo "[LOG] $@"
}

echosuccess() {
  echo "[SUCCESS] $@"
}

detect_os() {
  local uname_out
  uname_out="$(uname -s)"

  case "$uname_out" in
    Linux*)
      echo "linux"
      ;;
    Darwin*)
      echo "macOS"
      ;;
    MINGW*|MSYS*|CYGWIN*)
      echo "windows"
      ;;
    *)
      echo "unknown"
      ;;
  esac
}

OS="$(detect_os)"

echolog "Detected OS: $OS"

if [[ "$OS" == "windows" ]]; then
  export MSYS=winsymlinks:nativestrict
  echolog "Windows detected, git bash used, MSYS is set to winsymlinks:nativestrict"
fi

ask() {
  while true; do
    printf "%s [y/n]: " "$1"
    read -r yn
    case "$yn" in
      [Yy]*) return 0 ;;
      [Nn]*) return 1 ;;
      *) echo "Unsupported answer" ;;
    esac
  done
}

windows_only() {
  local os="$1"
  shift

  if [[ "$os" == "windows" ]]; then
    "$@"
  fi
}

link_force() {
  local src="$1"
  local dst="$2"

  if [[ -e "$dst" || -L "$dst" ]]; then
    echolog "File already exists, overwriting"
    rm -f "$dst"
  fi

  ln -s "$src" "$dst"
  echosuccess "Created symbolic link: $dst"
}

#=== git config ===
link_force "$HOME/dotfiles/git/.gitconfig" "$HOME/.gitconfig"

#=== powershell profile ===
windows_only "$OS" link_force \
  "$HOME/dotfiles/powershell/Microsoft.PowerShell_profile.ps1" \
  "$HOME/Documents/WindowsPowerShell/Microsoft.PowerShell_profile.ps1"

#=== windows terminal ===
windows_only "$OS" link_force \
  "$HOME/dotfiles/terminal/settings.json" \
  "$HOME/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json"

#=== fastfetch ===
if ask "Do you want to configure fastfetch?"; then
  link_force "$HOME/dotfiles/fastfetch/config.jsonc" \
    "$HOME/.config/fastfetch/config.jsonc"

  link_force "$HOME/dotfiles/fastfetch/logo.txt" \
    "$HOME/.config/fastfetch/logo.txt"
else
  echolog "Skipping fastfetch configuration"
fi
