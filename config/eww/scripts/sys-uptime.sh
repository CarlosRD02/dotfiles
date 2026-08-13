#!/usr/bin/env bash
# Tiempo de encendido del sistema, formato compacto en español.
while true; do
    awk '/^[0-9]/{s=int($1); d=int(s/86400); h=int((s%86400)/3600); m=int((s%3600)/60); \
        if(d>0) printf "%d d %d h %d min\n", d, h, m; \
        else if(h>0) printf "%d h %d min\n", h, m; \
        else printf "%d min\n", m}' /proc/uptime
    sleep 30
done
