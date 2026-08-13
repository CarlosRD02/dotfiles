#!/usr/bin/env bash

# Emite el volumen del sink por defecto como entero 0-100 (deflisten).
while true; do
    out="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)"
    printf '%s' "$out" | awk -F'Volume: ' '{print $2}' | LC_ALL=C awk '{printf "%d", $1*100}'
    echo
    sleep 2
done
