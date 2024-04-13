# Path to your oh-my-zsh installation.
export HOME=/home/rojetsavage
export ZSH=$HOME/.config/.oh-my-zsh

#XDG paths
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_PICTURES_DIR=$HOME/picures
export XDG_STATE_HOME=$HOME/.local/state

#Other paths
export GOPATH=$XDG_DATA_HOME/go
export HISTFILE=$XDG_DATA_HOME/zsh/history
export ANDROID_HOME=$XDG_DATA_HOME/android/sdk                                                  
export HISTFILE=$XDG_STATE_HOME/zsh/history 
export NVM_DIR=$XDG_DATA_HOME/nvm
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export ANDROID_HOME=$XDG_DATA_HOME/Android/Sdk
export ANDROID_USER_HOME=$XDG_DATA_HOME/android
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export GNUPGHOME=$XDG_DATA_HOME/gnupg     	#might cause problems                              
export DOTNET_CLI_HOME=$XDG_DATA_HOME/dotnet                            
export AWS_SHARED_CREDENTIALS_FILE=$XDG_CONFIG_HOME/aws/credentials     
export AWS_CONFIG_FILE=$XDG_CONFIG_HOME/aws/config 
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv

# Default Apps
export BROWSER="brave-browser"
export VIDEO="vlc"

#Source user configuration
source $ZSH/custom/config.zsh	#plugins have to be loaded before oh-my-zsh.sh
source $ZSH/oh-my-zsh.sh
source $ZSH/custom/path.zsh
source $ZSH/custom/functions.zsh
source $ZSH/custom/aliases.zsh

