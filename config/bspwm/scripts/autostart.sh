#!/bin/bash

# Wait for bspwm to initialize
sleep 1

dunst &

# Polkit authentication
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

#lxpolkit &

#variety &

# thunar daemon
#if ! pgrep -af thunar > /dev/null; then thunar --daemon & fi
thunar --daemon & 

# Mate Polkit
#/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

# Mate Polkit Debian
/usr/libexec/polkit-mate-authentication-agent-1 &

# Nitrogen Restore
nitrogen --restore &

# Volume control
nm-applet &


#volumeicon -&

#parcellite &
#diodon &

#package-update-indicator &

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
export SSH_AUTH_SOCK

dbus-update-activation-environment --all

#plank &

# Eww
eww daemon
sleep 1
eww open bar
