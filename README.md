# 🏠 Dotfiles

This repo contains my personal dotfiles to setup new machines in a fast(ish) way.

Don't blindly use this dotfiles since they are my desired config. Fork the repo and check out what you need and what you dont before applying them.

## 📋 Content

- **Git**: `.gitconfig`
- **Windows Terminal**: `settings.json`
- **PowerShell**: `Microsoft.PowerShell_profile.ps1`

## 🚀 How to Install

> [!WARNING]
> Before you go any further please backup your current settings as the script will overwrite them.

### 📦 Requirements

- Git
- Any app/program you want to apply the settings to

### Fast install

> If you are on Windows make sure to execute Git Bash as admin.

```bash
git clone git@github.com:Croking09/dotfiles.git "$HOME/dotfiles"
cd ~/.dotfiles
./install.sh
```

### Manual install

> If you just want to apply settings to some programs.

```bash
git clone git@github.com:Croking09/dotfiles.git "$HOME/dotfiles"

#If you are using Windows and Git Bash make sure to execute as admin and:
export MSYS=winsymlinks:nativestrict

#Create the symlinks manually
ln -s $HOME/dotfiles/git/.gitconfig $HOME/.gitconfig
```
