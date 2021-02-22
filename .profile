# Set our umask
umask 022

# Set our default path
export BROWSER=/usr/bin/vivaldi-snapshot
export BSPWM_SOCKET="/tmp/bspwm-socket"
export EDITOR=/usr/bin/vim
export GUI_EDITOR=/usr/bin/vim
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export PANEL_FIFO="/tmp/panel-fifo"
export PATH="/usr/bin:/usr/local/bin:/usr/local/sbin:/usr/bin/core_perl:/usr/bin/vendor_perl:/usr/bin/site_perl"
export QT_QPA_PLATFORMTHEME="qt5ct"
export TERMINAL=/usr/bin/alacritty
export VISUAL=/usr/bin/code
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS=/usr/etc/xdg:/etc/xdg
export ZDOTDIR=.config/zsh

# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
	for profile in /etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi

# Source global bash config
if test "$PS1" && test "$BASH" && test -r /etc/bash.bashrc; then
	. /etc/bash.bashrc
fi

# Termcap is outdated, old, and crusty, kill it.
unset TERMCAP

# Man is much better than us at figuring this out
unset MANPATH
