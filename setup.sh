#!/bin/bash

set -e

echo "Updating package lists..."
sudo apt update

echo "Installing required packages..."
sudo apt install -y \
    tmux \
    polybar \
    rofi \
    xclip \
    feh \
    ripgrep \
    zsh \
    git \
    kitty \
    curl \
    wget \
    maim \
    brightnessctl \
    pamixer \
    bluetooth \
    bluemoon \
    flatpak

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# confirm kitty was installed via apt
if command -v kitty &> /dev/null; then
    echo "kitty is already installed via apt."
else
    echo "kitty not found! you may need to install it manually."
fi

# install Oh My Zsh (if not installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh My Zsh already installed."
fi

# change default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s "$(which zsh)"
else
    echo "Default shell is already zsh."
fi

echo "Setup complete. Restart your terminal or log out/in for shell changes to take effect."

