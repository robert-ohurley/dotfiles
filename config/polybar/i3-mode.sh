#!/usr/bin/env bash
# Polybar module: show the active i3 binding mode (e.g. RESIZE), blank when in
# the default mode. Event-driven via i3's "mode" subscription so it appears the
# instant you enter the mode.
set -o pipefail

source "$HOME/.config/theme/palette.sh"

emit() {
  local mode="$1"
  if [ -z "$mode" ] || [ "$mode" = "default" ]; then
    printf '\n'                                   # nothing in default mode
  else
    local up
    up=$(printf '%s' "$mode" | tr '[:lower:]' '[:upper:]')
    # pink block with dark text
    printf '%%{B#%s}%%{F#%s}  %s  %%{F-}%%{B-}\n' "$PINK" "$BG" "$up"
  fi
}

emit default
i3-msg -t subscribe -m '[ "mode" ]' 2>/dev/null | while read -r line; do
  emit "$(printf '%s' "$line" | jq -r '.change // empty')"
done
