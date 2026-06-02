#!/usr/bin/env bash
# i3 login startup: launch the default apps onto their workspaces.
#
# Workspace-to-monitor assignment is NOT done here -- it lives in the i3 config
# ("workspace N output ...") and the autorandr postswitch hook. This script only
# launches Alacritty (ws1), Brave (ws2) and Slack (ws3) and moves each onto its
# workspace once its window appears.
set -uo pipefail

command -v i3-msg >/dev/null || exit 0
command -v jq     >/dev/null || exit 0

LOG=/tmp/i3-startup.log
exec >"$LOG" 2>&1
echo "=== i3 startup $(date) ==="

# window class -> target workspace number
declare -A WANT=( ["Alacritty"]=1 ["Brave-browser"]=2 ["Slack"]=3 )

# Launch each app once.
(alacritty &) ; (brave-browser &) ; (slack &)

find_con_id() {
  i3-msg -t get_tree | jq -r --arg C "$1" '
    recurse(.nodes[]?, .floating_nodes[]?)
    | select(.window_properties?.class == $C) | .id' | head -n1
}

# Poll for ~10s, moving each window to its workspace as soon as it shows up.
declare -A placed=()
deadline=$(( $(date +%s) + 10 ))
while [ "$(date +%s)" -lt "$deadline" ]; do
  remaining=0
  for cls in "${!WANT[@]}"; do
    [ -n "${placed[$cls]:-}" ] && continue
    id=$(find_con_id "$cls" || true)
    if [ -n "$id" ]; then
      i3-msg "[con_id=$id] move container to workspace number ${WANT[$cls]}" >/dev/null
      placed[$cls]=1
      echo "placed $cls -> ws ${WANT[$cls]}"
    else
      remaining=$((remaining+1))
    fi
  done
  (( remaining == 0 )) && break
  sleep 0.3
done

i3-msg 'workspace number 1' >/dev/null
echo "done."
