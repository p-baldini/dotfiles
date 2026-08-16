# Combine multiple tool to create a virtual side bar

#!/bin/sh

# show polybar
xdo show -N Polybar
xdo raise -N Polybar

# launch rofi menu
rofi -show drun

# when rofi close; hide polybar
xdo hide -N Polybar

