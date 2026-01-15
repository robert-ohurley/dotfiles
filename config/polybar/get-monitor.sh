#!/usr/bin/env bash
# Get the name of the display where the active/focused workspace is

# Get the focused workspace and its output from i3
if command -v i3-msg >/dev/null 2>&1 && command -v jq >/dev/null 2>&1; then
    i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true) | .output' 2>/dev/null || \
    xrandr | grep " connected" | awk '{print $1}' | head -n1
else
    # Fallback if jq not available
    xrandr | grep " connected" | awk '{print $1}' | head -n1
fi
