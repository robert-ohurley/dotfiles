#!/usr/bin/env bash
# Persistent i3 workspaces for polybar.
#
# i3 deletes a workspace as soon as it's empty and unfocused, so polybar's
# built-in internal/i3 module has nothing to show for it. This script renders
# THIS bar's workspaces always -- even empty ones (shown dimmed) -- matching the
# native module's styling, and switches workspace on left-click.
#
# Per-monitor split mirrors the i3 config / autorandr postswitch hook:
#   docked:  external (HDMI-1/DP-1) owns 1-3, laptop (eDP-1) owns 4-6
#   mobile:  laptop owns all of 1-6
# (occupied workspaces always render on whatever output they currently live on,
#  so e.g. 4-6 still appear if windows get pushed to them while undocked.)
#
# MONITOR is exported per-bar by launch.sh (MONITOR=$m polybar main).
set -o pipefail

SELF_MON="${MONITOR:-}"

# Colors come from the central palette (single source of truth).
source "$HOME/.config/theme/palette.sh"
C_BASE="#$BG"          # dark text on accent backgrounds
C_TEXT="#$FG"
C_SUBTEXT="#$SUBTEXT"
C_MAUVE="#$PURPLE"     # focused workspace accent
C_OVERLAY="#$SURFACE"
C_RED="#$RED"
C_DIM="#$MUTED"        # empty/persistent workspaces

detect_ext() {
  if   xrandr | grep -qE "^HDMI-1 connected [0-9]"; then echo "HDMI-1"
  elif xrandr | grep -qE "^DP-1 connected [0-9]";   then echo "DP-1"
  else echo "eDP-1"; fi
}

# Workspace numbers this bar's monitor "owns" (always shown, even when empty).
assigned_for() {
  local mon="$1" ext="$2" int="eDP-1"
  if [ "$ext" != "$int" ]; then
    [ "$mon" = "$ext" ] && { echo 1; echo 2; echo 3; }                 # docked: external
    [ "$mon" = "$int" ] && { echo 4; echo 5; echo 6; }                 # docked: laptop
  else
    # mobile: everything lives on the laptop, so all six stay visible
    [ "$mon" = "$int" ] && { echo 1; echo 2; echo 3; echo 4; echo 5; echo 6; }
  fi
}

render() {
  local ext ws_json
  ext=$(detect_ext)
  ws_json=$(i3-msg -t get_workspaces 2>/dev/null) || return

  declare -A FOC VIS URG EXIST OUTP
  while IFS=$'\t' read -r num foc vis urg outp; do
    EXIST[$num]=1
    [ "$foc" = "true" ] && FOC[$num]=1
    [ "$vis" = "true" ] && VIS[$num]=1
    [ "$urg" = "true" ] && URG[$num]=1
    OUTP[$num]="$outp"
  done < <(echo "$ws_json" | jq -r '.[] | "\(.num)\t\(.focused)\t\(.visible)\t\(.urgent)\t\(.output)"')

  # Show: workspaces currently on this monitor, plus owned numbers that don't
  # exist anywhere right now (the persistent placeholders).
  local nums=""
  for n in "${!EXIST[@]}"; do
    [ "${OUTP[$n]}" = "$SELF_MON" ] && nums+="$n"$'\n'
  done
  while read -r a; do
    [ -n "$a" ] && [ -z "${EXIST[$a]:-}" ] && nums+="$a"$'\n'
  done < <(assigned_for "$SELF_MON" "$ext")
  nums=$(printf '%s' "$nums" | grep -E '^[0-9]+$' | sort -nu)

  local out=""
  for n in $nums; do
    local fg bg seg
    if   [ -n "${URG[$n]:-}" ];   then bg="$C_RED";     fg="$C_BASE"
    elif [ -n "${FOC[$n]:-}" ];   then bg="$C_MAUVE";   fg="$C_BASE"
    elif [ -n "${VIS[$n]:-}" ];   then bg="$C_OVERLAY"; fg="$C_SUBTEXT"
    elif [ -n "${EXIST[$n]:-}" ]; then bg="";           fg="$C_TEXT"
    else                               bg="";           fg="$C_DIM"; fi

    if [ -n "${VIS[$n]:-}" ] && [ -z "${FOC[$n]:-}" ]; then
      seg="  🖥 ${n}  "
    else
      seg="  ${n}  "
    fi

    out+="%{A1:i3-msg workspace number ${n} >/dev/null:}"
    [ -n "$bg" ] && out+="%{B${bg}}"
    out+="%{F${fg}}${seg}%{F-}"
    [ -n "$bg" ] && out+="%{B-}"
    out+="%{A}"
  done
  printf '%s\n' "$out"
}

# Initial paint, then repaint on every i3 workspace event.
render
i3-msg -t subscribe -m '[ "workspace" ]' 2>/dev/null | while read -r _; do
  render
done
