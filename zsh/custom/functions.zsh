addPath() {
	echo "export PATH=$1:\$PATH" >> $ZSH/custom/path.zsh
}

#creates and attaches to a new tmux sesh if one doesn't already exist
#i'm a monogamous tmux session kinda guy
t() {

	if [ -z $(tls | grep "sesh") ]
	then
		tmux new -s sesh
	else
		tmux attach -t sesh
	fi
}

#simple navigation
f() {
	selected_directory=$(find ~/ -maxdepth 4 \( -path '*/.local/*' -o -path '*/.cache/*' -o -path '*/.config/*' -o -path '*/node_modules/*' \) -prune -o -type d -print | fzf)
	cd "$selected_directory"
}

