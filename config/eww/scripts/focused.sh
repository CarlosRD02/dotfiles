#!/usr/bin/env bash

print_focused() {
    local json class
    json="$(bspc query -T -n focused 2>/dev/null)" || { echo "Vacio"; return; }
    class="$(printf '%s' "$json" | jq -r '.client.className // empty' 2>/dev/null)"
    class="${class##*.}"

    # Nombres amigables para clases conocidas
    case "$class" in
        firefox-esr)    class="Firefox" ;;
        Brave-browser)  class="Brave" ;;
        kitty)          class="Kitty" ;;
        code)           class="Code" ;;
        beekeeper-studio) class="Beekeeper Studio" ;;
        TelegramDesktop) class="Telegram" ;;
        vlc)            class="VLC" ;;
        Xfce4-terminal) class="Terminal" ;;
    esac

    echo "${class:-Vacio}"
}

print_focused

bspc subscribe node_focus node_remove node_state desktop_focus | while read -r _; do
    print_focused
done
