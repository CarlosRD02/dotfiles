#!/usr/bin/env bash

while true; do
    if nmcli -t -f STATE g 2>/dev/null | grep -q "connected"; then
        echo "<span color='#98c379'>ON</span>"
    elif ip route show default 2>/dev/null | grep -q .; then
        echo "<span color='#98c379'>ON</span>"
    else
        echo "<span color='#ff5555'>OFF</span>"
    fi

    sleep 2
done
