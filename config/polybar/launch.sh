#!/usr/bin/env bash
# ~/.config/polybar/launch.sh

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar on each monitor
for m in $(polybar --list-monitors | cut -d: -f1); do
    MONITOR=$m polybar main &
done

echo "Polybar launched on all displays!"
