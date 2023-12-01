# Path to your oh-my-zsh installation.
export ZSH="$HOME/.config/.oh-my-zsh"

# Set theme
ZSH_THEME="agnoster"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

#Load plugins
plugins=(
	#git 			
	zsh-autosuggestions		
	sudo				
	colorize 			
 )

# User configuration

#Source custom files on startup
source $ZSH/oh-my-zsh.sh
source $ZSH/custom/path.zsh
source $ZSH/custom/functions.zsh
source $ZSH/custom/aliases.zsh
