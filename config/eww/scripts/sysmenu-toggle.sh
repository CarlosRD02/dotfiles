#!/usr/bin/env bash

# Alterna el menú del sistema.
# `eww close sysmenu` devuelve 1 si la ventana NO estaba abierta -> abrimos;
# devuelve 0 si la cerró -> solo limpiamos el overlay transparente.
if ! eww close sysmenu >/dev/null 2>&1; then
    # Si el widget de música está abierto, lo cerramos para no solapar.
    eww close music >/dev/null 2>&1
    eww close music-overlay >/dev/null 2>&1
    # Arma el flag que suprime el onchange de inicialización del slider de
    # volumen (si no, abrir el menú pisaría el volumen del sistema).
    touch /tmp/eww-sys-volume-init
    eww open sysmenu-overlay
    eww open sysmenu
else
    eww close sysmenu-overlay >/dev/null 2>&1
fi
