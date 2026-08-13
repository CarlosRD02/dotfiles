#!/usr/bin/env bash

# Tipo de red activa. Uso: sys-net.sh <get|open>
#   get:  emite wifi|ethernet|none en loop (deflisten)
#   open: abre el editor de conexiones (NetworkManager)

ACTIVE="$(nmcli -t -f DEVICE,TYPE,STATE dev status 2>/dev/null | awk -F: '$3=="connected" && ($2=="wifi" || $2=="ethernet") {print $2; exit}')"

case "${1:-get}" in
    get)
        while true; do
            ACTIVE="$(nmcli -t -f DEVICE,TYPE,STATE dev status 2>/dev/null | awk -F: '$3=="connected" && ($2=="wifi" || $2=="ethernet") {print $2; exit}')"
            echo "${ACTIVE:-none}"
            sleep 2
        done
        ;;
    open)
        nm-connection-editor &
        ;;
esac
