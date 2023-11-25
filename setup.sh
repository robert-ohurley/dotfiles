#tmux
ln -s -f ~/dotfiles/tmux ~/.config/

#nvim
#remove directories first before replacing with symlinks
rm -rf ~/.config/nvim/after
rm -rf ~/.config/nvim/core
rm -rf ~/.config/nvim/lua

ln -s -f ~/dotfiles/nvim/after ~/.config/nvim/
ln -s -f ~/dotfiles/nvim/core ~/.config/nvim/
ln -s -f ~/dotfiles/nvim/lua ~/.config/nvim/

#zsh
ln -s -f ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -s -f ~/dotfiles/zsh/aliases.zsh ~/.oh-my-zsh/custom/aliases.zsh

#git
ln -s -f ~/dotfiles/git/.gitconfig ~/.gitconfig

#vscode
ln -s -f ~/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json

echo "Completed symlinking config files"