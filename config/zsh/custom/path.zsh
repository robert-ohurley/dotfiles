#XDG paths
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XDG_CONFIG_HOME=$HOME/.config
export XDG_PICTURES_DIR=$HOME/picures
export XDG_STATE_HOME=$HOME/.local/state

#Other variables
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_USER_HOME=$XDG_DATA_HOME/android
export ANDROID_SDK_ROOT=$HOME/Android
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
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NVM_DIR=$XDG_CONFIG_HOME/nvm
export NODEJS_HOME=/lib/node/nodejs
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/starship/starship.toml
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export FNM_PATH="$HOME/.local/share/fnm"
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export PYENV_ROOT="$XDG_DATA_HOME"/pyenv
# export GSTREAMER_LINUX_SDK_ROOT=/usr/lib/gstreamer-1.0-linux-x86-64-1.26
export GSTREAMER_LINUX_SDK_ROOT=/home/rob/deps/gstreamer-1.0-android-universal-1.24.13/armv7


export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export PATH="/usr/bin/psql:$PATH"


export GIT_AUTHOR_NAME="Robert Hurley"
export GIT_AUTHOR_EMAIL="robert-hurley@hotmail.com.au"
export GIT_COMMITTER_NAME="Robert Hurley"
export GIT_COMMITTER_EMAIL="robert-hurley@hotmail.com.au"


# Default Apps
export BROWSER="brave-browser"
export VIDEO="vlc"

#PATH
export PATH=~/Programming/scripts/:$PATH
export PATH=$HOME/.local/share/cargo/bin/eza:$PATH
export PATH=~/Projects/scripts:$PATH
export PATH=/home/root/.local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:/usr/local/go/bin
export PATH=/usr/local/lib/x86_64-linux-gnu:$PATH
export PATH=$HOME/go:$PATH
export PATH=$NODEJS_HOME:$PATH
export PATH=$HOME/.local/share/nvim/mason/bin:$PATH
export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/Android/Sdk/platform-tools/:$PATH
export PATH=/usr/lib/android-studio/bin/:$PATH
# export PATH=/usr/lib/jdk1.8.0_202/bin:$PATH
# export PATH=$PATH:/opt/gradle/gradle-7.6.3/bin
export PATH=$HOME/.local/share:$PATH
export PATH=$HOME/.local/share/npm/bin/:$PATH
export PATH=$HOME/.local/share/go/bin:$PATH
export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
