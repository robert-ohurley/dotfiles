#git
alias ga='git add .'
alias gupdate='git commit -m "update"'
alias gl='git log --oneline --graph'
alias gp='git push origin main'
alias gpull='git pull origin main'
alias gs='git status'
alias gsub='git submodule foreach git pull origin main'
alias gg="git add . && git commit -m 'update' && git push origin main"
alias gd="git diff --staged --color-words"
alias lg="lazygit"
alias nvm="fnm"

#navigation
#alias f is a function

#misc
alias c='clear'
alias ls='ls -l'
alias echoServer='node ~/Projects/echoServer/index.js'
alias uu='sudo apt update && sudo apt upgrade'
alias b='btop'
alias l='exa --icons -F -H --group-directories-first -1'
alias talon='/home/rojetsavage/.local/share/talon/run.sh'

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


#prevent generation of dotfiles in $HOME - tidy up
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts" # Alias wget to use a custom hsts cache file location
alias nvidia-settings=nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings

#sourcing
alias szsh='source $XDG_CONFIG_HOME/zsh/.zshrc'
alias stmux='tmux source-file $XDG_CONFIG_HOME/tmux/tmux.conf'
