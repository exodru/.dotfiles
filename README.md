# dotfiles

These are my personal dotfiles, managed with GNU Stow.  
I'm typically running CachyOS (based on Arch Linux) with the i3 window manager.

## Structure
* **fonts**: Custom fonts (NerdFonts).
* **i3**: i3 window manager configuration.
* **kitty**: Kitty terminal emulator configuration.
* **nvim**: Neovim configuration.
* **polybar**: Polybar status bar configuration.
* **rofi**: Rofi dmenu replacement configuration.
* **picom**: Picom compositor (I only use it for bg blur & transparency tbh).
* **tmux**: Tmux terminal multiplexer configuration.
* **walls**: Wallpapers that I use and like.
* **zsh**: Zsh shell configuration.
* **dunst**: Notifications
* **setup.sh**: A script for initial setup (dependencies and whatever, etc.)

## How I'm using these
### Prerequisites
* **CachyOS (or any Arch based distro with X11)** - I haven't tested it on any other distros.
* **i3 Window Manager**: The i3 configuration assumes you have i3 installed.
* **GNU Stow**: Essential for managing the symlinks. If you don't have it, install it:
    ```bash
    sudo pacman -S stow
    ```

### Cloning the Repository
I recommended you to clone this repository into your home directory.

```bash
cd ~
git clone https://github.com/prozod/.dotfiles.git
```

### Syncing with GNU Stow
Once you cloned the repo, `cd` into the `.dotfiles` directory and use `stow` to create symlinks for each configuration.
**Important**: Before stowing, ensure that you don't have existing configuration files or directories that would cause conflicts with the symlinks.
To sync a specific configuration, for example, Neovim:

```bash
cd ~/.dotfiles
stow nvim
```

You can repeat this for each configuration you want to sync:

**Alternatively, to sync all at once (careful with potential conflicts):**
```bash
stow */ # this will attempt to stow all top-level directories
```
