#!/usr/bin/env lua










-- Configuración de Lemonbar para bspwm
local lemonbar_cmd = "lemonbar -p -f 'Arial:size=10' -f 'MesloLGS Nerd Font:size=10' -B '#2E3440' -F '#D8DEE9' -g x30"

-- Función para ejecutar comandos y obtener su salida
local function get_command_output(cmd)
    local handle = io.popen(cmd)
    if not handle then return "" end
    local result = handle:read("*a")
    handle:close()
    return result:gsub("\n$", "")
end

-- Función principal para generar el contenido de la barra
local function generate_bar_content()
    local content = {}
    
    -- Lado izquierdo: Workspaces
    table.insert(content, "%{l}")
    
    -- Obtener workspaces de bspwm
    local wm_info = get_command_output("bspc wm --get-status")
    for workspace in wm_info:gmatch("[^:]+") do
        local status, name = workspace:match("(.)(.+)")
        if status == "O" or status == "F" then
            -- Workspace activo o con foco
            table.insert(content, "%{+u}%{U#88C0D0} " .. name .. " %{-u}")
        elseif status == "o" then
            -- Workspace ocupado
            table.insert(content, "%{F#A3BE8C} " .. name .. " %{F-}")
        else
            -- Workspace libre
            table.insert(content, "%{F#4C566A} " .. name .. " %{F-}")
        end
    end
    
    -- Centro: Ventana actual
    table.insert(content, "%{c}")
    local window_title = get_command_output("xtitle"):gsub("&", "&amp;")
    if #window_title > 50 then
        window_title = window_title:sub(1, 47) .. "..."
    end
    table.insert(content, window_title)
    
    -- Lado derecho: System info
    table.insert(content, "%{r}")
    
    -- Volumen
    local volume = get_command_output("pamixer --get-volume-human")
    table.insert(content, "🔊 " .. volume .. " ")
    
    -- Brillo (requiere light package)
    local brightness = get_command_output("light -G"):gsub("%.%d+", "")
    table.insert(content, "💡 " .. brightness .. "% ")
    
    -- Batería
    local battery = get_command_output("cat /sys/class/power_supply/BAT0/capacity 2>/dev/null || echo 'N/A'")
    table.insert(content, "🔋 " .. battery .. "% ")
    
    -- Fecha y hora
    local datetime = get_command_output("date '+%a %d %b %H:%M'")
    table.insert(content, "📅 " .. datetime)
    
    return table.concat(content, "")
end

-- Bucle principal
while true do
    local content = generate_bar_content()
    print(content)
    io.flush()
    os.execute("sleep 1")
end
