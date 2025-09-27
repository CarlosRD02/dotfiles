#!/bin/bash

# Colores
BG="#2E3440"    # Fondo oscuro
FG="#D8DEE9"    # Texto claro
ACCENT="#81A1C1" # Color de acento azul
ACTIVE="#A3BE8C" # Verde para workspace activo
OCCUPIED="#EBCB8B" # Amarillo para workspaces ocupados
URGENT="#BF616A"   # Rojo para ventanas urgentes

# Fuentes - Nerd Font para símbolos (sin el tamaño en el nombre)
FONT="Arial:size=10"
NERD_FONT="Symbols Nerd Font:size=10"  # Nombre corregido

# Matar cualquier instancia previa de lemonbar
pkill -f "lemonbar"

# Función para generar el contenido de la barra
generate_bar_content() {
    while true; do
        # --- LADO IZQUIERDO: WORKSAPCES ---
        workspace_str=""
        
        # Obtener todos los monitores
        for monitor in $(bspc query -M --names); do
            # Icono de monitor (Nerd Font)
            workspace_str+="%{F$ACCENT}%{F-} "
            
            # Obtener workspaces para este monitor (solo números, sin símbolos)
            desktop_list=$(bspc query -D -m $monitor --names | grep -E '^[0-9]+$')
            
            for desktop in $desktop_list; do
                # Verificar estado del workspace
                if bspc query -D -d $desktop --names | grep -q "$desktop" && [ "$(bspc query -D -d --names)" = "$desktop" ]; then
                    # Workspace actual y enfocado
                    workspace_str+="%{F$ACTIVE}%{B#4C566A} $desktop %{B-}%{F-}"
                elif bspc query -D -d $desktop --names | grep -q "occupied"; then
                    # Workspace ocupado pero no enfocado
                    workspace_str+="%{F$OCCUPIED} $desktop %{F-}"
                elif bspc query -D -d $desktop --names | grep -q "urgent"; then
                    # Workspace con ventana urgente
                    workspace_str+="%{F$URGENT} $desktop %{F-}"
                else
                    # Workspace vacío
                    workspace_str+="%{F$FG} $desktop %{F-}"
                fi
            done
            
            # Separador entre monitores
            workspace_str+="  "
        done
        
        # --- CENTRO: VENTANA ACTUAL ---
        window_title=$(xdotool getwindowfocus getwindowname 2>/dev/null || echo "bspwm")
        if [ ${#window_title} -gt 60 ]; then
            window_title="$(echo $window_title | cut -c -57)..."
        fi
        
        # --- LADO DERECHO: SISTEMA Y HORA ---
        # Uso de CPU
        cpu_usage=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{printf "%.1f%%", 100 - $1}')
        
        # Uso de memoria
        mem_usage=$(free -m | awk 'NR==2{printf "%.1f%%", $3*100/$2}')
        
        # Volumen (con símbolo Nerd Font)
        volume=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oP '\d+%' | head -1 || echo "N/A")
        volume_icon=""
        if [ "$volume" = "0%" ] || [ "$volume" = "MUTE" ]; then
            volume_icon=""
        fi
        
        # Batería (si está disponible)
        battery_info=""
        if [ -f "/sys/class/power_supply/BAT0/capacity" ]; then
            battery_percent=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
            if [ -n "$battery_percent" ]; then
                if [ "$battery_percent" -gt 80 ]; then
                    battery_icon=""
                elif [ "$battery_percent" -gt 60 ]; then
                    battery_icon=""
                elif [ "$battery_percent" -gt 40 ]; then
                    battery_icon=""
                elif [ "$battery_percent" -gt 20 ]; then
                    battery_icon=""
                else
                    battery_icon=""
                fi
                battery_info=" $battery_icon $battery_percent%"
            fi
        fi
        
        # Fecha y hora
        current_date=$(date "+%d/%m")
        current_time=$(date "+%H:%M")
        
        # --- CONSTRUIR OUTPUT CON SÍMBOLOS NERD FONT ---
        right_side=" $cpu_usage  $mem_usage $volume_icon $volume$battery_info  $current_date  $current_time"
        
        echo "%{l}$workspace_str%{c}$window_title%{r}$right_side"
        
        sleep 1
    done
}

# Ejecutar lemonbar con múltiples fuentes (índice 0 y 1)
generate_bar_content | lemonbar -p -b -f "$FONT" -f "$NERD_FONT" -B "$BG" -F "$FG" -g "x24" | bash