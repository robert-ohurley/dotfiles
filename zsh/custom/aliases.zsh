#git
alias ga='git add .'
alias gupdate='git commit -m "update"'
alias gl='git log --oneline --graph'
alias gp='git push origin main'
alias gpull='git push origin main'
alias gs='git status'
alias gsub='git submodule foreach git pull origin main'
alias gogit="git add . && git commit -m 'update' && git push origin main"

#navigation 
alias f='cd "$(find ~ ~/Uni ~/Projects ~/Programming -mindepth 1 -maxdepth 3 -type d | fzf)"'

#misc
alias c='clear'
alias ls='ls -l'
alias echoServer='node ~/Projects/echoServer/index.js'
alias uu='sudo apt update && sudo apt upgrade'

#tmux
alias t='tmux'
alias tk='tmux kill-server'
alias tl='tmux list-sessions'
alias ta='tmux attach'
alias ts='tmux source-file ~/.config/tmux/tmux.conf'

#prevent generation of dotfiles in $HOME - tidy up
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts" # Alias wget to use a custom hsts cache file location
alias nvidia-settings=nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings

#sourcing 
alias szsh='source $XDG_CONFIG_HOME/zsh/.zshrc'
alias stmux='tmux source-file ~/.config/tmux/tmux.conf'
