#!/usr/bin/env bash

# Temperaturas del sistema. Uso: sys-temps.sh <cpu|sys>
#   cpu: temperatura del paquete (x86_pkg_temp)
#   sys: sensor de la placa (acpitz)
while true; do
    case "$1" in
        cpu)
            v="$(cat /sys/class/thermal/thermal_zone2/temp 2>/dev/null || echo 0)"
            echo "$((v / 1000))°C"
            ;;
        sys)
            v="$(cat /sys/class/hwmon/hwmon0/temp1_input 2>/dev/null || echo 0)"
            echo "$((v / 1000))°C"
            ;;
    esac
    sleep 3
done
