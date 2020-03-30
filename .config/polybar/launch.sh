#!/bin/sh

# terminate already running bar instances
killall -q polybar

polybar example >> /tmp/polybar.log 2>&1 &
