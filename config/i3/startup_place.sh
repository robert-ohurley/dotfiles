#!/usr/bin/env bash
set -euo pipefail

LOG=/tmp/i3-startup.log
exec >"$LOG" 2>&1
echo "=== i3 startup $(date) ==="

need() { command -v "$1" >/dev/null || { echo "Missing $1"; exit 1; }; }
need jq
need i3-msg
need xrandr

INT="eDP-1"
EXT="HDMI-1"

# Detect HDMI connection
if xrandr | grep -q "^HDMI-1 connected"; then
  echo "External monitor detected: HDMI-1"
  EXT="HDMI-1"
else
  echo "No external monitor found, using laptop only"
  EXT="$INT"
fi

# Helper to pin workspace to specific output
pin_ws() {
  local ws="$1"
  local out="$2"
  i3-msg "workspace number ${ws}; move workspace to output ${out}" >/dev/null
}

# === Assign workspaces ===
# Workspaces 1–3 go to HDMI (or fallback to laptop)
# Workspace 4 stays on laptop
pin_ws 1 "$EXT"
pin_ws 2 "$EXT"
pin_ws 3 "$EXT"
pin_ws 4 "$INT"

# Focus back to workspace 1
i3-msg 'workspace number 1' >/dev/null

# === Swallow placeholders ===
mk_con_json() { printf '%s' "{ \"type\":\"con\", \"nodes\":[{ \"type\":\"con\", \"swallows\": $1 }] }"; }

tmp1=$(mktemp); mk_con_json '[{"class":"^Alacritty$"},{"instance":"(?i)^alacritty$"}]' >"$tmp1"
tmp2=$(mktemp); mk_con_json '[{"class":"^(?i)Brave(-browser)?$"}]' >"$tmp2"
tmp3=$(mktemp); mk_con_json '[{"class":"^Slack$"}]' >"$tmp3"

i3-msg "workspace number 1; append_layout $tmp1" >/dev/null
i3-msg "workspace number 2; append_layout $tmp2" >/dev/null
i3-msg "workspace number 3; append_layout $tmp3" >/dev/null

# === Launch apps (once) ===
(alacritty &) ; (brave-browser &) ; (slack &)

# === Poll and move windows if not swallowed ===
deadline=$(( $(date +%s) + 10 ))
declare -A want=( ["Alacritty"]=1 ["Brave-browser"]=2 ["Brave"]=2 ["Slack"]=3 )
declare -A placed=()

find_con_id() {
  local class="$1"
  i3-msg -t get_tree | jq -r --arg C "$class" '
    recurse(.nodes[]?, .floating_nodes[]?)
    | select(.window_properties?.class == $C)
    | .id' | head -n1
}

while [ "$(date +%s)" -lt "$deadline" ]; do
  remaining=0
  for cls in "${!want[@]}"; do
    key="$cls:${want[$cls]}"
    [[ -n "${placed[$key]:-}" ]] && continue
    con_id=$(find_con_id "$cls" || true)
    if [[ -n "$con_id" ]]; then
      echo "Placing $cls -> WS ${want[$cls]} (con_id=$con_id)"
      i3-msg "[con_id=$con_id] move container to workspace number ${want[$cls]}" >/dev/null
      placed[$key]=1
    else
      remaining=$((remaining+1))
    fi
  done
  (( remaining == 0 )) && break
  sleep 0.2
done

# === Re-pin and cleanup ===
pin_ws 1 "$EXT"
pin_ws 2 "$EXT"
pin_ws 3 "$EXT"
pin_ws 4 "$INT"
i3-msg 'workspace number 1' >/dev/null

rm -f "$tmp1" "$tmp2" "$tmp3"
echo "Done."
