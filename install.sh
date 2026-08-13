#!/bin/bash

set -e
set -u

# --- Helper Functions for Output ---
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

info() { echo -e "${GREEN}[*] $1${NC}"; }
warn() { echo -e "${YELLOW}[!] $1${NC}"; }
error() { echo -e "${RED}[X] $1${NC}"; exit 1; }

# Ensure we are in the dotfiles directory
if [ ! -f "install.sh" ]; then
    error "Please run this script from inside the dotfiles repository directory."
fi

# System updates & packages installation
info "Updating system and installing packages..."
sudo apt update -y
sudo apt install -y psmisc jq bluez xorg lightdm pipewire-audio pipewire-pulse \
    network-manager stow git unzip wget zsh alacritty tmux zoxide eza bat fzf \
    atuin neovim ripgrep tree-sitter-cli fd-find build-essential xclip i3 i3status dex xss-lock \
    network-manager-gnome pulseaudio-utils brightnessctl feh maim picom polybar \
    dunst rofi papirus-icon-theme lxappearance autoconf gcc make pkg-config \
    libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev \
    libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev \
    libxcb-randr0-dev libxcb-image0-dev libxcb-util0-dev libxcb-xrm-dev \
    libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev libgif-dev

#i3lock-color installation
sudo apt remove -y i3lock
info "Building and installing i3lock-color..."
(
    cd /tmp
    rm -rf i3lock-color
    git clone https://github.com/Raymo111/i3lock-color.git
    cd i3lock-color
    ./install-i3lock-color.sh
)

# Setup fonts
info "Installing fonts..."
mkdir -p ~/.local/share/fonts
cp -r fonts/* ~/.local/share/fonts/
fc-cache -fv

# Backup existing configurations
info "Backing up existing configs before deleting them..."
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# List of targets to backup to prevent stow conflicts
TARGETS=(
    "$HOME/.zshrc"
    "$HOME/.p10k.zsh"
    "$HOME/.config/alacritty"
    "$HOME/.config/nvim"
    "$HOME/.config/i3"
    "$HOME/.config/dunst"
    "$HOME/.config/polybar"
    "$HOME/.scripts"
)

for target in "${TARGETS[@]}"; do
    if [ -e "$target" ] || [ -L "$target" ]; then
        warn "Moving $target to $BACKUP_DIR/"
        mv "$target" "$BACKUP_DIR/"
    fi
done

# Stow configuration files
info "Creating necessary directories..."
mkdir -p ~/.config ~/Pictures

info "Stowing dotfiles..."
stow zsh alacritty nvim i3 dunst polybar scripts

# Set wallpaper
info "Setting up wallpaper and executable permissions..."
cp wallpaper.jpg ~/Pictures/

# Setup scripts permissions
chmod +x ~/.scripts/* || true
chmod +x ~/.config/polybar/cuts/launch.sh || true
chmod +x ~/.config/polybar/cuts/scripts/*.sh || true

# Install neovim plugins
info "Installing Neovim plugins via Lazy..."
nvim --headless "+Lazy! sync" +qa || warn "Neovim plugin sync finished with some warnings."

#Change default Shell
info "Changing default shell to Zsh..."
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
fi

# Reboot prompt
echo ""
info "Installation complete!"
info "A backup of your previous configs was saved to: $BACKUP_DIR"
echo ""

read -p "Do you want to reboot now to apply all changes? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    info "Rebooting system..."
    sudo reboot
else
    info "Reboot skipped. Please log out and log back in for all changes to take effect."
fi
