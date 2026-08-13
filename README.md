# Dotfiles

> ⚠️ **Note:** This configuration has only been tested on **Debian 13**.

This repository contains my fully customized desktop environment configurations, managed with [GNU Stow](https://www.gnu.org/software/stow/). 

## Key Components

| Component | Choice | Description |
| :--- | :--- | :--- |
| **Window Manager** | [i3wm](https://i3wm.org/) | Tiling window manager with i3-gaps enabled for aesthetics. |
| **Status Bar** | [Polybar](https://polybar.github.io/) | Dual-bar setup (top/bottom). |
| **Terminal** | [Alacritty](https://alacritty.org/) | GPU-accelerated terminal emulator. |
| **Shell** | [Zsh](https://www.zsh.org/) | Powered by zinit, Powerlevel10k, zoxide, and fzf. |
**Editor** | [Neovim (NvChad)](https://nvchad.com/) | Fast and customized Neovim configuration framework based on Lua and Lazy.nvim. |
| **Launcher** | [Rofi](https://github.com/davatorium/rofi) | Themed application launcher and menus. |
| **Launcher** | [Rofi](https://github.com/davatorium/rofi) | Themed application launcher and menus. |
| **Notifications**| [Dunst](https://dunst-project.org/) | Lightweight and customizable notification daemon. |
| **Lock Screen** | [i3lock-color](https://github.com/Raymo111/i3lock-color) | Modern lock screen with blur and custom colors. |
| **Compositor** | [Picom](https://github.com/yshui/picom) | Standalone compositor for transparency and window effects. |

## Installation

The automated installation script will install all necessary dependencies, and deploy the new configurations using `stow`.

### Setup
1. Clone this repository into your home directory:
   ```bash
   git clone git@github.com:StarManiaAM/dotfiles.git ~/.dotfiles && cd ~/.dotfiles
   ```
2. Run the installation script:
   ```bash
   ./install.sh
   ```
3. **Reboot** your system or log out/in to apply all changes.

> **Backup:** The script automatically backs up your existing configuration files into a timestamped directory `~/.dotfiles_backup_YYYYMMDD_HHMMSS`.
