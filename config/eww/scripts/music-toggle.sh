#!/usr/bin/env bash

# Alterna el widget de música.
# `eww close music` devuelve 1 si la ventana NO estaba abierta -> abrimos
# (con el overlay que captura el click afuera); devuelve 0 si la cerró
# (cerramos también el overlay).
if ! eww close music >/dev/null 2>&1; then
    # Si el menú del sistema está abierto, lo cerramos para no solapar.
    eww close sysmenu >/dev/null 2>&1
    eww close sysmenu-overlay >/dev/null 2>&1
    # Suprime el onchange de inicializacion del slider de volumen del popup
    # (si no, al abrir el popup eww pisaria el volumen del reproductor).
    touch /tmp/eww-music-volume-init
    # El overlay se abre PRIMERO para que quede DEBAJO del popup
    # (eww apila en orden de apertura; si no, el overlay cubre los
    # botones y cualquier click cierra el popup).
    eww open music-overlay
    eww open music
else
    eww close music-overlay >/dev/null 2>&1
fi
