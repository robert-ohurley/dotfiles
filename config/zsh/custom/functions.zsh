addPath() {
	echo "export PATH=$1:\$PATH\n" >> $ZSH/custom/path.zsh
}

t() {
	selected=$(find ~/ -maxdepth 4 \( -path '*/.local/*' -o -path '*/.cache/*' -o -path '*/.config/*' -o -path '*/node_modules/*' \) -prune -o -type d -print | fzf)

	if [[ -z $selected ]]; then
	    exit 0
	fi

	selected_name=$(basename "$selected" | tr . _)
	#Start a new session or attach to an existing session named $selected_name
	tmux new-session -A -c $selected -s $selected_name
	
	cd selected
}

# Simple navigation
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

mkcd() {
	mkdir $1
	cd $1
}


# Nvm takes up ~90% of shell loading time. Alias to a function and lazy load.
nvm() {
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
nvm
}

