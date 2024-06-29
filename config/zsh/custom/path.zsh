export HOME=/home/rojetsavage

#XDG paths
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_PICTURES_DIR=$HOME/picures
export XDG_STATE_HOME=$HOME/.local/state

#Other variables
export ANDROID_HOME=$XDG_DATA_HOME/android/sdk
export ANDROID_HOME=$XDG_DATA_HOME/Android/Sdk
export ANDROID_USER_HOME=$XDG_DATA_HOME/android
export AWS_SHARED_CREDENTIALS_FILE=$XDG_CONFIG_HOME/aws/credentials
export AWS_CONFIG_FILE=$XDG_CONFIG_HOME/aws/config 
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export CUDA_CACHE_PATH=$XDG_CACHE_HOME/nv
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export DOTNET_CLI_HOME=$XDG_DATA_HOME/dotnet
export GNUPGHOME=$XDG_DATA_HOME/gnupg     	#might cause problems
export GOPATH="$XDG_DATA_HOME"/go
export GRADLE_USER_HOME=$XDG_DATA_HOME/gradle
export HISTFILE=$XDG_STATE_HOME/zsh/history 
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot=$XDG_CONFIG_HOME/java
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history 
export NVM_DIR=$XDG_DATA_HOME/nvm
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup

# Default Apps
export BROWSER="brave-browser"
export VIDEO="vlc"

#PATH
export PATH=~/Programming/scripts/:$PATH
export PATH=~/Projects/scripts:$PATH
export PATH=/home/root/.local/bin:$PATH
export PATH=/home/rojetsavage/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=/home/rojetsavage/go:$PATH
export PATH=/home/rojetsavage/go/bin:$PATH
export PATH=/home/rojetsavage/.local/share:$PATH
export PATH=/home/rojetsavage/.local/share/go/bin:$PATH
export PATH="$PATH:/opt/nvim-linux64/bin"

