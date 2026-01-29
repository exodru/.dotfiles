# ------ General Env & Path ----------
export EDITOR=nvim
export VISUAL=nvim
export TERM="xterm-256color"
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"

# Clean up PATH at once (Add new paths here)
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:/opt/nvim-linux-x86_64/bin:$HOME/go/bin:/usr/local/go/bin:$HOME/zig-x86_64:$PYENV_ROOT/bin:$PATH"

# ------ Completion & Fpath Setup ----------
# This MUST happen before any completion plugins are loaded
if [ -d /usr/share/zsh/site-functions ]; then
  fpath=(/usr/share/zsh/site-functions $fpath)
fi

# Initialize completion system (only if autocomplete isn't doing it)
autoload -Uz compinit
compinit

# ------ Plugins Block ----------

# 1. Autosuggestions (The "Phantom" text)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    # Behavior setup
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8" 
    bindkey '^[[C' forward-char  # Right Arrow to accept
    bindkey '^ ' autosuggest-accept # Ctrl + Space to accept
fi

# 2. Autocomplete (The dropdown menu)
# NOTE: If your ghost text flickers or feels laggy, comment this block out.
if [ -f /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh ]; then
    source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
fi


# 3. Syntax Highlighting (ALWAYS LAST IN PLUGINS)
if [ -f /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]; then
    source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null
fi

# ------ Aliases & Functions ----------
alias xc='xclip -selection clipboard'
alias nv='nvim'
alias nvi='nvim ~/.config/nvim'
alias wb='nvim ~/.config/waybar'
alias hp='nvim ~/.config/hypr'
alias kit='nvim ~/.config/kitty'
alias tmu='nvim ~/.tmux.conf'
alias dw='cd ~/Downloads'
alias x='exit'
alias lg='lazygit'
alias dots='cd ~/.dotfiles'
alias gd='go doc --src '
alias py='python3'
alias venv='source .venv/bin/activate'
alias light='/home/DRU/devel/python/yee/.venv/bin/python /home/DRU/devel/python/yee/app.py'

csh() { curl "https://cheat.sh/$1"; }

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# ------ External Tools ----------

# GDK Fix for OpenGL on Wayland
export GDK_BACKEND=x11 # Keeping this since native Wayland was crashing
export GDK_PIXBUF_MODULEDIR=/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders
export GDK_PIXBUF_MODULE_FILE=/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# SDKMAN
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Rust & Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Pyenv
eval "$(pyenv init --path)"
eval "$(pyenv init - zsh)"

# Initializations (Last for performance)
eval "$(zoxide init zsh)"
eval "$(oh-my-posh init zsh --config ~/.config/posh/0xdru.omp.json)"

echo "|---> ZSH Config loaded <---|"
