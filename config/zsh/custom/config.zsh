#Moves zsh history location
HISTFILE=$XDG_CONFIG_HOME/zsh/.zsh_history

#Prevent creation of some of the ZSH_COMPDUMP files
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

#prevent generation of dotfiles in $HOME - tidy up
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts" 
alias nvidia-settings=nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings
export PYTHON_HISTORY="$XDG_CONFIG_HOME"/python


