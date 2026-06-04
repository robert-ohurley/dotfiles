#!/usr/bin/env bash
# Print the git branch for tmux status-right, shortened to fit the terminal.
# Usage: git-branch.sh <dir> [width]
#   called as: #(~/.config/tmux/git-branch.sh '#{pane_current_path}' '#{client_width}')
dir="${1:-$PWD}"
width="${2:-200}"

branch=$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null) || exit 0
[ -n "$branch" ] || exit 0

# Max branch length scales with terminal width (gradual breakpoints).
if   [ "$width" -lt 70 ];  then max=0      # very narrow: icon only
elif [ "$width" -lt 90 ];  then max=14
elif [ "$width" -lt 110 ]; then max=22
elif [ "$width" -lt 130 ]; then max=32
elif [ "$width" -lt 160 ]; then max=44
elif [ "$width" -lt 190 ]; then max=58
else                            max=80
fi

if [ "$max" -eq 0 ]; then
  printf ' '                                  # icon only
elif [ "${#branch}" -gt "$max" ]; then
  printf ' %s… ' "${branch:0:max}"            # truncated + ellipsis
else
  printf ' %s ' "$branch"                     # full
fi
