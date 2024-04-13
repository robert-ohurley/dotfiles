# Set theme
ZSH_THEME="agnoster"

HISTSIZE=100

#Moves zsh history location
HISTFILE=$ZSH/.zsh_history

compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION" 

#Prevent creation of some of the ZSH_COMPDUMP files
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
compinit -d $ZSH/cache/.zcompdump

#Load plugins
plugins=(
	zsh-autosuggestions	
	sudo				
	colorize 			
 )

