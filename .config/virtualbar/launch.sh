# Combine multiple tool to create a virtual side bar

#!/bin/sh

# show polybar
xdo show -N Polybar
xdo raise -N Polybar

# show notifications
alacritty		\
	--class InfoBox	\
	--hold 		\
	--config-file .config/virtualbar/alacritty.yml	\
	-e sh -c 'tput civis; COLUMNS=$(expr $COLUMNS - 4); cat .cache/virtualbar/notifications.dat | grep -e APPNAME -e SUMMARY | tail -n 25 | awk -F"=\"|\"" "{print \$2}" | awk "!(NR%2){if (length(p\$0) > $COLUMNS) print substr(p\$0, 0, $COLUMNS)\"...\"; else print p\$0}{p=\$0\": \"}"' &

# launch rofi menu
rofi -show drun

# when rofi close; kill notification panel
kill `ps ax | grep "alacritty --class InfoBox" | awk '{print $1}' | head -n 1`

# when rofi close; hide polybar
xdo hide -N Polybar

