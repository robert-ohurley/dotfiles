#precmd runs before each command but only after the first command
precmd() {
	source $ZSH/custom/aliases.zsh
}

#simple add to zsh path
add2Path() {
	echo "export PATH=$1:\$PATH" >> $ZSH/custom/path.zsh
}
