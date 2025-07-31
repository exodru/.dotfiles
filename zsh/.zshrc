# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export EDITOR=nvim
export VISUAL=nvim
export TERM="xterm-256color"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

plugins=(
	git
  z
	zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh
source $HOME/repos/zsh-autocomplete/zsh-autocomplete.plugin.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
# export PATH=$PATH:/usr/local/go/bin
export PATH="$HOME/go/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin

alias xc='xclip -selection clipboard'
alias nv='nvim'
alias nvi='nvim ~/.config/nvim'
alias kit='nvim ~/.config/kitty'
alias pb='nvim ~/.config/polybar'
alias i3wm='nvim ~/.config/i3'
alias repos='cd ~/repos'
alias x='exit'
alias lg='lazygit'
alias ra='ranger'
alias gd='go doc --src '
alias pc='nv ~/.config/picom/picom.conf'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

#miktex
export PATH="/home/prozod/bin:$PATH"

#rofi wifi module
export PATH="$HOME/.config/rofi/rofi_wifi_menu.sh:$PATH"

# java swing antialiased text
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

export XDG_DATA_DIRS="$XDG_DATA_DIRS:/var/lib/flatpak/exports/share:/home/$USER/.local/share/flatpak/exports/share"

# display message on load/reload
echo ">>> .zshrc loaded <<<"

export PATH="$HOME/.local/share/nvim/mason/packages/codelldb/extension/adapter:$PATH"
