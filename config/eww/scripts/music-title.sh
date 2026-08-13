#!/usr/bin/env bash

# Emite el titulo de la cancion actual, limitado a 28 caracteres (agrega "…"
# si se corta). Si el reproductor no expone titulo (ej. VLC con archivos
# locales solo manda la URL), usa el nombre del archivo como fallback.
# --follow bloquea hasta que aparezca un reproductor; cuando el reproductor
# desaparece, sale del loop y reportamos vacio.

# Recibe "titulo|url" y devuelve el titulo (o el nombre del archivo).
resolve_line() {
    local line="$1" title url
    title="${line%%|*}"
    url="${line#*|}"
    if [ -z "$title" ]; then
        title=$(python3 -c 'import urllib.parse, os, sys
u = sys.argv[1].strip()
print(urllib.parse.unquote(os.path.splitext(os.path.basename(u))[0]))' "$url" 2>/dev/null)
    fi
    printf '%s' "$title"
}

# Corta a 27 caracteres y agrega "…" si hace falta.
truncate_title() {
    local title="$1" truncated
    truncated=$(printf '%s' "$title" | cut -c1-27)
    if [ "$truncated" != "$title" ]; then
        printf '%s\n' "${truncated}…"
    else
        printf '%s\n' "$title"
    fi
}

while true; do
    line=$(playerctl metadata --format "{{title}}|{{xesam:url}}" 2>/dev/null)
    if [ -z "$line" ]; then
        echo ""
    else
        truncate_title "$(resolve_line "$line")"
    fi
    # Sigue los cambios de metadata; sale cuando el reproductor desaparece.
    playerctl metadata --format "{{title}}|{{xesam:url}}" --follow 2>/dev/null | while IFS= read -r line; do
        truncate_title "$(resolve_line "$line")"
    done
    sleep 2
done
