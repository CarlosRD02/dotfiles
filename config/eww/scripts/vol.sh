#!/usr/bin/env bash

while true; do
    out="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)"

    if printf '%s' "$out" | grep -q "MUTED"; then
        echo "muted"
    else
        printf '%s' "$out" | awk -F'Volume: ' '{print $2}' | LC_ALL=C awk '{printf "%.0f%%\n", $1*100}'
    fi

    sleep 2
done
