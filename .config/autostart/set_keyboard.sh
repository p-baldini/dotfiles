#!/bin/sh

# Keyboard setups
LilyKeyboardDeviceID=`xinput -list | grep Lily58 | awk '{print $4}' | grep -v 'Lily58' | awk '{gsub(/[A-Z,a-z,=, ]/,"")}1' | grep '[0-9]' | sort`
if [[ ! -z "$LilyKeyboardDeviceID" ]]; then
	        setxkbmap -device $LilyKeyboardDeviceID -layout us
fi

