#!/usr/bin/env bash

# Emite el estado del reproductor (Playing / Paused / Stopped) y se queda
# escuchando cambios con --follow (requiere playerctl >= 2.0).
# --follow bloquea hasta que aparezca un reproductor; cuando el reproductor
# desaparece, sale del loop y reportamos Stopped.

while true; do
    playerctl status --follow 2>/dev/null
    echo "Stopped"
    sleep 3
done
