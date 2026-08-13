#!/usr/bin/env bash

while true; do
    src="$(wpctl status 2>/dev/null | sed -n '/Sources:/,/Filters:/p' | grep -oE "[0-9]+\." | head -1 | tr -d '.')"

    if [ -n "$src" ] && wpctl get-volume "$src" 2>/dev/null | grep -q "MUTED"; then
        echo "off"
    else
        echo "on"
    fi

    sleep 2
done
