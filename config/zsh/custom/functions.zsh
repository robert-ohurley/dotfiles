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
	selected_directory=$(find ~/ -maxdepth 4 \( -path '*/.local/*' -o -path '*/.cache/*' -o -path '*/.config/*' -o -path '*/node_modules/*' -o -path '*/yazi/*' -o -path '*/rustup/*' -o -path '*/.rbenv/*' -o -path '*/.docker/*' -o -path '*/.gem/*' -o -path '*/snap/*' \) -prune -o -type d -print | fzf)
	cd "$selected_directory"
}

y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
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
loadnvm() {
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}

