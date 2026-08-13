#!/usr/bin/env bash

# Volumen ALSA. Uso: sys-volume.sh <get|set>
#   get:   emite el volumen actual (0-100) en loop (deflisten)
#   set N: fija el volumen a N%

case "${1:-get}" in
    get)
        while true; do
            amixer sget Master 2>/dev/null | sed -n 's/.*\[\([0-9]*\)%\].*/\1/p' | head -1 || echo "0"
            sleep 2
        done
        ;;
    set)
        [ -n "$2" ] && amixer set Master "$(printf '%.0f' "$2")%" >/dev/null 2>&1
        ;;
esac
