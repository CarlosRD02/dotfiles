#!/usr/bin/env bash

# Governor de energía del CPU. Uso: sys-cpugovernor.sh <get|set|toggle>
#   get:          emite el governor actual en loop (deflisten)
#   set <gov>:    fija el governor indicado
#   toggle:       alterna entre los governors disponibles

GOV_PATH="/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor"

get_gov() {
    tr -d '\n' < "$GOV_PATH" 2>/dev/null || echo "unknown"
}

set_gov() {
    if ! echo "$1" > "$GOV_PATH" 2>/dev/null; then
        pkexec sh -c "echo '$1' > '$GOV_PATH'"
    fi
    eww update sys-cpu-governor "$(get_gov)"
}

case "${1:-get}" in
    get)
        while true; do
            get_gov
            sleep 2
        done
        ;;
    set)
        if [ -n "$2" ]; then
            set_gov "$2"
        fi
        ;;
    toggle)
        cur="$(get_gov)"
        if [ "$cur" = "performance" ]; then
            set_gov schedutil
        else
            set_gov performance
        fi
        ;;
esac
