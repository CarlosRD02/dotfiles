#!/usr/bin/env bash

# Ejecuta una acción del menú del sistema. Cierra los popups antes de actuar.
# Uso: sysmenu-action.sh <settings|network|lock|logout|suspend|reboot|shutdown>
eww close sysmenu >/dev/null 2>&1
eww close sysmenu-power >/dev/null 2>&1
eww close sysmenu-overlay >/dev/null 2>&1

case "$1" in
    settings)  lxappearance & ;;
    wallpaper) nitrogen & ;;
    network)   nm-connection-editor & ;;
    lock)     xflock4 & ;;
    logout)   bspc quit ;;
    suspend)  systemctl suspend ;;
    reboot)   systemctl reboot ;;
    shutdown) systemctl poweroff ;;
esac
