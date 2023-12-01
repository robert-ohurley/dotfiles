#tmux
rm -rf ~/.config/tmux
ln -s -f ~/dotfiles/tmux ~/.config/

#nvim
#remove directories first before replacing with symlinks
rm -rf ~/.config/nvim/after
rm -rf ~/.config/nvim/core
rm -rf ~/.config/nvim/lua
S
ln -s -f ~/dotfiles/nvim/after ~/.config/nvim/
ln -s -f ~/dotfiles/nvim/core ~/.config/nvim/
ln -s -f ~/dotfiles/nvim/lua ~/.config/nvim/

#zsh
ln -s -f ~/dotfiles/zsh/.zshrc ~/.zshrc
rm -rf ~/.config/.oh-my-zsh/custom 
ln -s -f ~/dotfiles/zsh/custom ~/.config/.oh-my-zsh/custom
S
#git
ln -s -f ~/dotfiles/git/.gitconfig ~/.gitconfig

#vscode
ln -s -f ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json

echo "Completed symlinking config files"
