# dotfiles

These are my personal dotfiles, I manage them with GNU Stow.  
I'm typically running Debian (currently on 13.1.0 Trixie) with either XFCE or i3 window manager.

## Structure

- **fonts**: Custom fonts (NerdFonts).
- **i3**: i3 window manager configuration.
- **kitty**: Kitty terminal emulator configuration.
- **nvim**: Neovim configuration.
- **xfce**: My XFCE DE settings and keymaps.
- **polybar**: Polybar status bar configuration.
- **rofi**: Rofi dmenu replacement configuration.
- **tmux**: Tmux terminal multiplexer configuration.
- **themes**: My icons and theme that I use on XFCE (Qogir Dark).
- **walls**: Wallpapers that I use and like.
- **zsh**: Zsh shell configuration.
- **dunst**: Notifications
- **xmodmap**: I only use this and load it at startup on XFCE to make CapsLock act as Ctrl-L.
- **setup.sh**: A script for initial setup (dependencies and whatever, etc.)

## How I'm using these

### Prerequisites

- **i3 Window Manager**: The i3 configuration assumes you have i3 installed.
- **GNU Stow**: Essential for managing the symlinks. If you don't have it, install it:
- **Polybar, Rofi, Dunst**: For the status bar, app launcher and notifications
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

To undo certain configurations (if stow placed them wrong or idk)

```bash
cd ~/.dotfiles
stow -D <directory name or whatever, ex: nvim>
```
