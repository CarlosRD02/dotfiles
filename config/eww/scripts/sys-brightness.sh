#!/usr/bin/env bash

# Brillo de pantalla vía xrandr (decorativo: solo lectura). Uso: sys-brightness.sh get
# Emite el brillo actual (0-100) en loop (deflisten)

get_brightness() {
    OUTPUT="$(xrandr --current --verbose 2>/dev/null | awk '/ connected /{print $1; exit}')"
    [ -z "$OUTPUT" ] && { echo "100"; return; }
    xrandr --current --verbose 2>/dev/null | \
        awk -v o="$OUTPUT" '$0 ~ o {on=1} on && /Brightness:/ {gsub(/[^0-9.]/, "", $2); printf "%.0f\n", $2*100; exit}'
}

case "${1:-get}" in
    get)
        while true; do
            get_brightness
            sleep 2
        done
        ;;
esac
