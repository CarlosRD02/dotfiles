#!/usr/bin/env bash

MODE_FILE="$HOME/.config/eww/scripts/clock.mode"

[ -f "$MODE_FILE" ] || echo "cal" > "$MODE_FILE"

clock() {
    local time
    time="$(date +"%I:%M $(LC_TIME=C date +%p)")"
    if grep -q "time" "$MODE_FILE" 2>/dev/null; then
        echo "$time"
    else
        echo "<span color='#c678dd' font='MesloLGS Nerd Font Bold'>CAL</span> $(date +"%a, %-d %b") $time"
    fi
}

while true; do
    clock
    sleep 2
done
