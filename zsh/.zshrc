# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/.oh-my-zsh"

# Set theme
ZSH_THEME="agnoster"

HISTSIZE=1000

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

#Load plugins
plugins=(
	#git 			
	zsh-autosuggestions		
	sudo				
	colorize 			
 )

#Prevent creation of some of the ZSH_COMPDUMP files
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
compinit -d $ZSH/cache/.zcompdump

#Moves zsh history location
HISTFILE=$ZSH/.zsh_history

#Source user configuration
source $ZSH/oh-my-zsh.sh
source $ZSH/custom/path.zsh
source $ZSH/custom/functions.zsh
source $ZSH/custom/aliases.zsh
source $ZSH/custom/config.zsh
