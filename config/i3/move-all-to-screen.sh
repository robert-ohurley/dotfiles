#!/usr/bin/env bash
# Toggle all i3 workspaces between available displays

# Get available outputs
OUTPUTS=($(xrandr | grep " connected" | awk '{print $1}'))
[ ${#OUTPUTS[@]} -eq 0 ] && exit 1

# Get workspace data
WS_DATA=$(i3-msg -t get_workspaces)
WORKSPACES=($(echo "$WS_DATA" | jq -r '.[].name' | sort -V | uniq))
[ ${#WORKSPACES[@]} -eq 0 ] && exit 0

# If only one display, move all workspaces to it (handles disconnected display case)
if [ ${#OUTPUTS[@]} -eq 1 ]; then
    TARGET="${OUTPUTS[0]}"
    CURRENT_WS=$(echo "$WS_DATA" | jq -r '.[] | select(.focused==true) | .name' 2>/dev/null || echo "")
    
    # Move workspaces in reverse order (so workspace 1 is moved last and appears first)
    for ((i=${#WORKSPACES[@]}-1; i>=0; i--)); do
        ws="${WORKSPACES[$i]}"
        output=$(echo "$WS_DATA" | jq -r ".[] | select(.name==\"$ws\") | .output")
        if [ "$output" != "$TARGET" ]; then
            i3-msg "workspace \"$ws\"; move workspace to output $TARGET" >/dev/null 2>&1 || true
            sleep 0.1
        fi
    done
    
    [ -n "$CURRENT_WS" ] && i3-msg "workspace \"$CURRENT_WS\"" >/dev/null 2>&1 || true
    exit 0
fi

# Identify outputs
LAPTOP=""
EXTERNAL=""
for output in "${OUTPUTS[@]}"; do
    if [ "$output" = "eDP-1" ]; then
        LAPTOP="$output"
    elif [ -z "$EXTERNAL" ]; then
        EXTERNAL="$output"
    fi
done
[ -z "$LAPTOP" ] && LAPTOP="${OUTPUTS[0]}"
[ -z "$EXTERNAL" ] && EXTERNAL="${OUTPUTS[1]:-${OUTPUTS[0]}}"

# Count workspaces per output (including disconnected outputs)
COUNT_LAPTOP=0
COUNT_EXTERNAL=0
COUNT_DISCONNECTED=0
for ws in "${WORKSPACES[@]}"; do
    output=$(echo "$WS_DATA" | jq -r ".[] | select(.name==\"$ws\") | .output")
    if [ "$output" = "$LAPTOP" ]; then
        ((COUNT_LAPTOP++))
    elif [ "$output" = "$EXTERNAL" ]; then
        ((COUNT_EXTERNAL++))
    else
        # Workspace is on a disconnected output
        ((COUNT_DISCONNECTED++))
    fi
done

# Determine target output
if [ $COUNT_DISCONNECTED -gt 0 ]; then
    # If any workspaces are on disconnected displays, move all to laptop
    TARGET="$LAPTOP"
elif [ $COUNT_LAPTOP -gt 0 ] && [ $COUNT_EXTERNAL -gt 0 ]; then
    [ $COUNT_LAPTOP -gt $COUNT_EXTERNAL ] && TARGET="$EXTERNAL" || TARGET="$LAPTOP"
elif [ $COUNT_LAPTOP -gt 0 ]; then
    TARGET="$EXTERNAL"
else
    TARGET="$LAPTOP"
fi

# Get current workspace
CURRENT_WS=$(echo "$WS_DATA" | jq -r '.[] | select(.focused==true) | .name' 2>/dev/null || echo "")

# Move workspaces that need moving
# If moving to laptop, reverse order so workspace 1 is moved last (appears first)
if [ "$TARGET" = "$LAPTOP" ]; then
    # Reverse order when moving to laptop
    for ((i=${#WORKSPACES[@]}-1; i>=0; i--)); do
        ws="${WORKSPACES[$i]}"
        output=$(echo "$WS_DATA" | jq -r ".[] | select(.name==\"$ws\") | .output")
        if [ "$output" != "$TARGET" ]; then
            i3-msg "workspace \"$ws\"; move workspace to output $TARGET" >/dev/null 2>&1 || true
            sleep 0.1
        fi
    done
else
    # Normal order when moving to external
    for ws in "${WORKSPACES[@]}"; do
        output=$(echo "$WS_DATA" | jq -r ".[] | select(.name==\"$ws\") | .output")
        if [ "$output" != "$TARGET" ]; then
            i3-msg "workspace \"$ws\"; move workspace to output $TARGET" >/dev/null 2>&1 || true
            sleep 0.1
        fi
    done
fi

# Restore focus
[ -n "$CURRENT_WS" ] && i3-msg "workspace \"$CURRENT_WS\"" >/dev/null 2>&1 || true
