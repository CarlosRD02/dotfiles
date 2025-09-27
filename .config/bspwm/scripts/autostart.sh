#!/bin/bash

# Wait for bspwm to initialize
sleep 1





# Notifications
#dunst &

# Polkit authentication
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
lxpolkit &

# Volume control
volumeicon &

# Network manager
nm-applet &

package-update-indicator &

xdman &
sleep 2
xdotool search --name "xdman" windowminimize %@ 


eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK

dbus-update-activation-environment --all


#plank &

# Bluetooth
#blueman-applet &

# Compositor (si no se inició en bspwmrc)
# picom --config ~/.config/picom.conf &

# Otros programas
# discord &
# telegram-desktop &
