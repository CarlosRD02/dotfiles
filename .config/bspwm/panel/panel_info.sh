#!/bin/bash

# Requerido para bspwm
bspc subscribe desktop_focus \
    | while read -r line; do
        bspwm_workspaces
    done

# Módulo de fecha y hora
# Usamos un bucle para actualizarlo cada segundo
while true; do
    echo "clock $(date '+%a %d/%m %H:%M')"
    sleep 1s
done &

# Módulo de batería (puedes necesitar cambiar BAT0 por el nombre de tu batería)
while true; do
    BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
    BATTERY_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)

    if [[ "$BATTERY_STATUS" == "Discharging" ]]; then
        STATUS_SYMBOL=""
    elif [[ "$BATTERY_STATUS" == "Charging" ]]; then
        STATUS_SYMBOL=""
    else
        STATUS_SYMBOL=""
    fi

    echo "battery $STATUS_SYMBOL $BATTERY_CAPACITY%"
    sleep 5s
done &

# Módulo de volumen (requiere `amixer` o similar)
# Escucha cambios de volumen para actualizar
amixer sget Master \
    | while read -r line; do
        VOLUME=$(amixer sget Master | awk -F'[][]' '/dB/ {print $2}')
        if [[ $(amixer sget Master | awk -F'[][]' '/dB/ {print $3}') == "off" ]]; then
            echo "volume   MUTE"
        else
            echo "volume 墳  $VOLUME"
        fi
    done &
