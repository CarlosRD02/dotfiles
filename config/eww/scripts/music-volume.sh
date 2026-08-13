#!/usr/bin/env bash

# Volumen del reproductor (playerctl). Uso: music-volume.sh <get|set>
#   get: emite el volumen actual como entero 0-100 en loop (deflisten).
#        playerctl devuelve 0..1 (VLC puede superar 1.0); lo acotamos a 100.
#   set N: fija el volumen del reproductor a N% (0-100).
# El flag /tmp/eww-music-volume-init (creado por music-toggle.sh al abrir el
# popup) suprime el onchange de inicializacion del slider: al crear el scale,
# eww dispara un onchange que pisaria el volumen real (posible mute).

export LC_NUMERIC=C

case "${1:-get}" in
    get)
        while true; do
            v=$(playerctl volume 2>/dev/null)
            if [ -z "$v" ]; then
                echo "0"
            else
                awk -v v="$v" 'BEGIN{ n=v*100+0.5; if (n>100) n=100; printf "%d", n }'
                echo
            fi
            sleep 1
        done
        ;;
    set)
        [ -n "$2" ] || exit 0
        if [ -f /tmp/eww-music-volume-init ]; then
            # Suprime el onchange de inicializacion (dentro de los 2s de abrir).
            if [ $(( $(date +%s) - $(stat -c %Y /tmp/eww-music-volume-init 2>/dev/null) )) -lt 2 ]; then
                exit 0
            fi
            rm -f /tmp/eww-music-volume-init
        fi
        playerctl volume "$(awk -v v="$2" 'BEGIN{ printf "%.3f", v/100 }')" >/dev/null 2>&1
        ;;
esac
