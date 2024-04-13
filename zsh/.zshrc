# Path to your oh-my-zsh installation.
export HOME=/home/rojetsavage
export ZSH="$HOME/.config/.oh-my-zsh"

#XDG paths
export cdXDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_PICTURES_DIR=$HOME/picures
export XDG_STATE_HOME=$HOME/.local/state

#Other paths
export GOPATH=$XDG_DATA_HOME/go
export HISTFILE=$XDG_DATA_HOME/zsh/history
export ANDROID_HOME="$XDG_DATA_HOME"/android/sdk                                                  
export HISTFILE="$XDG_STATE_HOME"/zsh/history 
export NVM_DIR="$XDG_DATA_HOME/nvm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export ANDROID_HOME='$XDG_DATA_HOME/Android/Sdk'
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc

# Default Apps
export BROWSER="brave-browser"
export VIDEO="vlc"

#Source user configuration
source $ZSH/oh-my-zsh.sh
source $ZSH/custom/config.zsh
source $ZSH/custom/path.zsh
source $ZSH/custom/functions.zsh
source $ZSH/custom/aliases.zsh


