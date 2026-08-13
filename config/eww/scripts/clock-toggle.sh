#!/usr/bin/env bash

MODE_FILE="$HOME/.config/eww/scripts/clock.mode"

if grep -q "cal" "$MODE_FILE" 2>/dev/null; then
    mode="time"
else
    mode="cal"
fi
echo "$mode" > "$MODE_FILE"

if [ "$mode" = "cal" ]; then
    val="<span color='#c678dd'>cal</span> $(date +"%a, %-d %b") $(date +"%I:%M $(LC_TIME=C date +%p)")"
else
    val="$(date +"%I:%M $(LC_TIME=C date +%p)")"
fi

eww update clock "$val" 2>/dev/null
