#Moves zsh history location
HISTFILE=$XDG_CONFIG_HOME/zsh/.zsh_history

#Prevent creation of some of the ZSH_COMPDUMP files
export ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST

#prevent generation of dotfiles in $HOME - tidy up
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias nvidia-settings=nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings
export PYTHON_HISTORY="$XDG_CONFIG_HOME"/python

# fnm
FNM_PATH="/home/rojetsavage/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="/home/rojetsavage/.local/share/fnm:$PATH"
  eval "`fnm env`"
fi
<<<<<<< HEAD


=======
>>>>>>> e810a2ea2f234c62991ce534ea88b7681fe2a6d4
