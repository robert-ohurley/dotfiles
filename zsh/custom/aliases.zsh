#git
alias ga='git add .'
alias gl='git log --oneline --graph'
alias gp='git push origin main'
alias gs='git status'

#navigation 
alias f='cd "$(find ~ ~/Uni ~/Projects ~/Programming -mindepth 1 -maxdepth 3 -type d | fzf)"'

#misc
alias c='clear'
alias ls='ls -l'

#tmux
alias tk='tmux kill-server'
alias tl='tmux list-sessions'
alias t='tmux attach'

alias echoServer='node ~/Projects/echoServer/index.js'
alias uu='sudo apt update && sudo apt upgrade'
