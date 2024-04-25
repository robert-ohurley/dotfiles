# Set theme
ZSH_THEME="agnoster"

#Load plugins
plugins=(
	zsh-autosuggestions	#real time type-ahead autocompletion	
	sudo			#prefix your current or previous commands with sudo by pressing esc twice.			
)

HISTSIZE=100

#Moves zsh history location
HISTFILE=$ZSH/.zsh_history

#Prevent creation of some of the ZSH_COMPDUMP files
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
#compinit -d $ZSH/cache/.zcompdump
#compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION" 

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

