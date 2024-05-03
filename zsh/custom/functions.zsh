addPath() {
	echo "export PATH=$1:\$PATH" >> $ZSH/custom/path.zsh
}

t() {

selected=$(find ~/ -maxdepth 4 \( -path '*/.local/*' -o -path '*/.cache/*' -o -path '*/.config/*' -o -path '*/node_modules/*' \) -prune -o -type d -print | fzf)

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
#Start a new session or attach to an existing session named $selected_name
tmux new-session -A -s $selected_name
}

#simple navigation
f() {
	selected_directory=$(find ~/ -maxdepth 4 \( -path '*/.local/*' -o -path '*/.cache/*' -o -path '*/.config/*' -o -path '*/node_modules/*' \) -prune -o -type d -print | fzf)
	cd "$selected_directory"
}

killport() {
	isNum='^[0-9]+$'

	if ! [[ $1 =~ $isNum ]] 
	then
		echo "Provide a valid port number" 
	else
		echo "Killing PID: $(lsof -ti :$1) on port $1"
		kill $(lsof -ti :$1)
	fi

}

