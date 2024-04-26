addPath() {
	echo "export PATH=$1:\$PATH" >> $ZSH/custom/path.zsh
}

#creates and attaches to a given tmux sesh if one doesn't already exist
ts() {
	if [ -z $1]
	then
		echo "Provide tmux session name"
		return 0  
	elif [ -z $(tls | grep "$1") ]
	then
		tmux new -s $1
	else
		tmux attach -t $1
	fi
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

