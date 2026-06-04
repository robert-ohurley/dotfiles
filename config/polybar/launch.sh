#!/usr/bin/env bash
# ~/.config/polybar/launch.sh

# Serialize concurrent invocations (e.g. autorandr postswitch racing a manual
# relaunch) -- without this, two overlapping runs each spawn a bar per monitor.
exec 200>"${XDG_RUNTIME_DIR:-/tmp}/polybar-launch.lock"
flock 200

killall -q polybar
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar on each monitor
for m in $(polybar --list-monitors | cut -d: -f1); do
    MONITOR=$m polybar main &
done

echo "Polybar launched on all displays!"
