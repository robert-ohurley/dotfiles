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
# Preferred outputs: DP-2 -> HDMI-1 -> INT
if xrandr | grep -q "^DP-2 connected"; then
  TARGET="DP-2"
elif xrandr | grep -q "^HDMI-1 connected"; then
  TARGET="HDMI-1"
else
  TARGET="$INT"
fi
echo "TARGET=$TARGET"

# Helper: pin a workspace to TARGET (creates it if needed)
pin_ws() {
  local ws="$1"
  i3-msg "workspace number ${ws}; move workspace to output ${TARGET}" >/dev/null
}

# 1) Pin WS 1..3 and end on 1
pin_ws 1
pin_ws 2
pin_ws 3
i3-msg 'workspace number 1' >/dev/null

# 2) Add swallow placeholders (minimal cons) to each WS
mk_con_json() { printf '%s' "{ \"type\":\"con\", \"nodes\":[{ \"type\":\"con\", \"swallows\": $1 }] }"; }

tmp1=$(mktemp); mk_con_json '[{"class":"^Alacritty$"},{"instance":"(?i)^alacritty$"}]' >"$tmp1"
tmp2=$(mktemp); mk_con_json '[{"class":"^(?i)Brave(-browser)?$"}]' >"$tmp2"
tmp3=$(mktemp); mk_con_json '[{"class":"^Slack$"}]' >"$tmp3"

i3-msg "workspace number 1; append_layout $tmp1" >/dev/null
i3-msg "workspace number 2; append_layout $tmp2" >/dev/null
i3-msg "workspace number 3; append_layout $tmp3" >/dev/null

# 3) Launch apps (once)
(alacritty &) ; (brave-browser &) ; (slack &)

# 4) Poll and place windows if any didn't swallow
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

# 5) Re-pin WS 1..3 to TARGET (just in case) and finish on WS1
pin_ws 1; pin_ws 2; pin_ws 3
i3-msg 'workspace number 1' >/dev/null

# Cleanup
rm -f "$tmp1" "$tmp2" "$tmp3"
echo "Done."
