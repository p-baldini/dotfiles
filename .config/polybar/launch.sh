#!/bin/sh

# kill any running picom instances and re-run it
killall -q picom >> /tmp/polybar.log 2>&1
picom >> /tmp/polybar.log 2>&1 &

# terminate already running bar instance and re-run it
killall -q polybar
polybar bottom >> /tmp/polybar.log 2>&1 &
