#!/bin/bash

# Wait for bspwm to initialize
sleep 1

#dunst &

# Polkit authentication
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
lxpolkit &

# Volume control
volumeicon &

# Network manager
nm-applet &

package-update-indicator &

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK

dbus-update-activation-environment --all

#plank &
