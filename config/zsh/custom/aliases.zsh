#git
alias gl='git log --oneline --graph'
alias gp='git pull origin master'
alias gs='git status'
alias gcm='git checkout master'
alias gd="git diff --staged --color-words"
alias lg="lazygit"
alias ld="lazydocker"
alias nvm="fnm"
alias servedir="python3 -m http.server 8000"

#navigation
#alias f is a function
alias b="cd /home/rob/dev/vivi-local-cloud/vivi-backend/"
alias p="cd /home/rob/dev/vivi-local-cloud/vivi-portal"
# alias b="cd /home/rob/dev/backups/__/__/__/vivi-local-cloud/vivi-backend/"
# alias p="cd /home/rob/dev/backups/__/__/__/vivi-local-cloud/vivi-portal/"
alias lcu="cd /home/rob/dev/vivi-local-cloud && dcu"
 
#misc
alias c='clear'
alias ls='ls -l'
alias uu='sudo apt update && sudo apt upgrade'
alias l='eza --icons -F -H --group-directories-first -1'

#nvim
alias vim='nvim'
alias v='nvim'
alias n='nvim'

#tmux
#alias t is a function
alias tk='tmux kill-server'
alias tls='tmux list-sessions'
alias ta='tmux -u attach'
alias td='tmux detach'

#docker
alias dip='docker exec -it vivi-local-cloud-vivi-portal-1 sh'
alias dib='docker exec -it vivi-local-cloud-vivi-backend-1 sh'
alias dic='docker exec -it vivi-local-cloud-vivi-client-1 sh'
alias dcu='docker compose up -d'
alias dps='docker ps'
alias dk='docker stop $(docker ps -q) && docker rm $(docker ps -q)'
alias dstop='docker stop $(docker ps -q)'

#prevent generation of dotfiles in $HOME - tidy up
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts" # Alias wget to use a custom hsts cache file location
alias nvidia-settings=nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings

#sourcing
alias szsh='source $XDG_CONFIG_HOME/zsh/.zshrc'
alias stmux='tmux source-file $XDG_CONFIG_HOME/tmux/tmux.conf'
