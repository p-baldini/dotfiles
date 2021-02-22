#!/bin/sh

## Executed by startx (run your window manager from here)

# merge in defaults and keymaps
xrdb -merge $HOME/.Xresources

## Start programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi
#if [ $TERM = linux ] || [ -e "/etc/systemd/system/graphical.target.wants/xlogin@$(whoami).service" ] ; then
#    exec dbus-launch --sh-syntax --exit-with-session bspwm-session;;
#fi

## Load appearance settings TODO
#xsetroot -cursor_name left_ptr &

## Reduces flicker. Disabling saves resources.
picom -b &

## Automount removable media
devmon &

## Notification manager
dunst &

## Polkit agent
/usr/bin/polkit-dumb-agent &

