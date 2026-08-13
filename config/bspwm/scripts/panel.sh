#!/bin/bash

pkill polybar
#polybar nord_bar -c ~/.config/polybar/nord-bar/config.ini &
#polybar main -c ~/.config/polybar/config.ini &
polybar default_bar -c ~/.config/polybar/default_bar/config.ini &
