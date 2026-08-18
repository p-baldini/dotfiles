# Tool to store dunst notifications in a file

#!/bin/sh


CACHE_DIR=$HOME/.cache/virtualbar/
CACHE_FILE=notifications.dat

# create cache dir if it does not already exist
mkdir -p $CACHE_DIR

# store the notification
cat << dunst >> "$CACHE_DIR$CACHE_FILE"
APPNAME="$1"
SUMMARY="$2"
BODY="$3"
ICON="$4"
URGENCY="$5"
dunst

