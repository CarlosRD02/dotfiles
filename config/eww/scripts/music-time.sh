#!/usr/bin/env bash

# Emite un campo del progreso del reproductor: "frac", "elapsed" o "total".
#   frac   -> 0..1 (para la barra de progreso)
#   elapsed -> mm:ss transcurrido
#   total  -> mm:ss total
# playerctl no emite eventos de posicion, asi que hacemos polling cada segundo.
# LC_NUMERIC=C: fuerza el punto decimal en awk/printf (el locale es_* usa coma
# y rompe el parseo de flotantes).

export LC_NUMERIC=C

field="$1"

format_time() {
    local secs="$1" m s
    m=$((secs / 60))
    s=$((secs % 60))
    printf "%02d:%02d" "$m" "$s"
}

while true; do
    pos=$(playerctl position 2>/dev/null)
    if [ -z "$pos" ]; then
        frac="0"
        elapsed="00:00"
        total="00:00"
    else
        len=$(playerctl metadata --format "{{mpris:length}}" 2>/dev/null)
        pos_s=$(printf "%.0f" "$pos")
        elapsed=$(format_time "$pos_s")
        if [ -n "$len" ] && [ "$len" -ne 0 ]; then
            frac=$(awk "BEGIN{ f=$pos*1000000/$len; if (f>1) f=1; printf \"%.3f\", f }")
            total=$(format_time $((len / 1000000)))
        else
            frac="0"
            total="00:00"
        fi
    fi

    case "$field" in
        frac) echo "$frac" ;;
        elapsed) echo "$elapsed" ;;
        total) echo "$total" ;;
    esac
    sleep 1
done
