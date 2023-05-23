#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

polybar --config=/home/bbaker/.config/polybar/config.ini nord &
#polybar --config=/home/bbaker/polybar-nord-theme/config.ini &
