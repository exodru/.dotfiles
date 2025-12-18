# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export EDITOR=nvim
export VISUAL=nvim
export TERM="xterm-256color"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="agnoster"
# ZSH_THEME="jreese"
# ZSH_THEME="awesomepanda"
ZSH_THEME="half-life"

plugins=(
	git
  	z
	zsh-autosuggestions
	fast-syntax-highlighting
	zsh-autocomplete
)


source $ZSH/oh-my-zsh.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export PATH="$HOME/go/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

alias xc='xclip -selection clipboard'
alias nv='nvim'
alias nvi='nvim ~/.config/nvim'
alias pb='nvim ~/.config/polybar'
alias pc='nvim ~/.config/picom.conf'
alias kit='nvim ~/.config/kitty'
alias dw='cd ~/Downloads'
alias nt='cd ~/notes'
alias repos='cd ~/repos'
alias x='exit'
alias lg='lazygit'
alias dots='cd ~/.dotfiles'
alias gd='go doc --src '

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#zig
export PATH="$HOME/zig-x86_64:$PATH"

#rofi wifi module
export PATH="$HOME/.config/rofi/rofi_wifi_menu.sh:$PATH"

# java swing antialiased text
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share"

# display message on load/reload
echo ">>> .zshrc loaded <<<"

export PATH="$HOME/.local/share/nvim/mason/packages/codelldb/extension/adapter:$PATH"

# YAZI SHELL WRAPPER
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# for rust
. "$HOME"/.cargo/env

. "$HOME/.local/bin/env"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init - zsh)"

#venv for molten, venv wrapper
# usage
# $ mkvenv myvirtualenv # creates venv under ~/.virtualenvs/
# $ venv myvirtualenv   # activates venv
# $ deactivate          # deactivates venv
# $ rmvenv myvirtualenv # removes venv

export VENV_HOME="$HOME/.virtualenvs"
[[ -d $VENV_HOME ]] || mkdir $VENV_HOME

lsvenv() {
  ls -1 $VENV_HOME
}

venv() {
  if [ $# -eq 0 ]
    then
      echo "Please provide venv name"
    else
      source "$VENV_HOME/$1/bin/activate"
  fi
}

mkvenv() {
  if [ $# -eq 0 ]
    then
      echo "Please provide venv name"
    else
      python3 -m venv $VENV_HOME/$1
  fi
}

rmvenv() {
  if [ $# -eq 0 ]
    then
      echo "Please provide venv name"
    else
      rm -r $VENV_HOME/$1
  fi
}


# filen-cli
PATH=$PATH:~/.filen-cli/bin
