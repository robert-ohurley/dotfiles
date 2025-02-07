mkbranch() {
  local number="$1"
  shift

  local parts=()
  for word in "$@"; do
    # Convert to lowercase and replace spaces/underscores with dash
    kebab=$(echo "$word" | tr '[:upper:]' '[:lower:]' | tr ' _' '-')
    parts+=("$kebab")
  done

  local suffix=$(IFS=- ; echo "${parts[*]}")

  branch_name="vivi-${number}-${suffix}"

  echo "$branch_name" | xclip -selection clipboard
  git checkout -b "$branch_name"
}


mkprname() {
  local branch_name prefix rest pr_title
  branch_name=$(git branch --show-current)

  prefix=$(echo "$branch_name" | sed -E 's/^(vivi-[0-9]+)-.*/\1/I' | tr '[:lower:]' '[:upper:]')
  rest=$(echo "$branch_name" | sed -E "s/^vivi-[0-9]+-//I" | tr '-' ' ' | awk '{print tolower($0)}')
  rest=$(echo "$rest" | awk '{$1=toupper(substr($1,1,1)) substr($1,2); print}')

  pr_title="${prefix} ${rest}"

  # Copy to clipboard only if a GUI clipboard is available
  if command -v xclip >/dev/null 2>&1 && { [ -n "${DISPLAY:-}" ] || [ -n "${WAYLAND_DISPLAY:-}" ]; }; then
    printf '%s' "$pr_title" | xclip -selection clipboard >/dev/null 2>&1 || true
  fi

  printf '%s' "$pr_title"
}

mkpr() {
  local base="${1:-master}"
  GH_EDITOR=true GH_PROMPT_DISABLED=1 gh pr create \
    --base "$base" \
    --head "$(git branch --show-current)" \
    --title "$(mkprname)" \
    --body "" \
    --web
}

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
	selected_directory=$(find ~/ -maxdepth 5 \( -path '*/.local/*' -o -path '*/.cache/*' -o -path '*/.config/*' -o -path '*/node_modules/*' -o -path '*/yazi/*' -o -path '*/rustup/*' -o -path '*/.rbenv/*' -o -path '*/.docker/*' -o -path '*/.gem/*' -o -path '*/snap/*' -o -path '*/tmp/*' \) -prune -o -type d -print | fzf)
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


#not as root
update_homelab_repo() {
  scp rojet@192.168.0.169:/opt/stacks/pihole/etc-pihole/custom.list "$HOME/dev/homelab/pihole/custom.list"
  scp -r "rojet@192.168.0.5:/etc/nginx/sites-available/*" /home/rob/dev/homelab/nginx/sites-available
}

update_nginx() {
  rsync -avz --progress /home/rob/dev/homelab/nginx/sites-available/ root@192.168.0.5:/etc/nginx/sites-available/
  ssh root@192.168.0.5 \
    'ln -sf /etc/nginx/sites-available/* /etc/nginx/sites-enabled/ &&
     nginx -t &&
     systemctl reload nginx'
}

update_pihole() {
  scp /home/rob/dev/homelab/pihole/custom.list root@192.168.0.169:/opt/stacks/pihole/etc-pihole/custom.list
}
