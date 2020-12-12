.PHONY: install dependencies

# CONSTANTS

INSTALL=dnf install -y
GROUP_INSTALL=dnf group install -y
REMOVE=dnf remove

# BUILD RULES

install: dependencies alacritty bspwm feh fish git picom polybar ranger rofi

alacritty: $(INSTALL) alacritty # terminal emulator

bspwm:	dependencies alacritty feh git picom polybar rofi # window manager
	git clone https://github.com/baskerville/bspwm.git
	git clone https://github.com/baskerville/sxhkd.git
	$(INSTALL) xcb-util-devel xcb-util-keysyms-devel xcb-util-wm-devel alsa-lib-devel terminus-fonts # TODO maybe remove last
	$(GROUP_INSTALL) "Development Tools"
	cd bspwm; make; make install; cd ..
	cd sxhkd; make; make install; cd ..
	chmod +x ~/.config/bspwm/bspwmrc
	rm -rf bspwm sxhkd

feh: # background manager
	$(INSTALL) feh
	aria2c https://upload.wikimedia.org/wikipedia/commons/0/0d/Great_Wave_off_Kanagawa2.jpg

fish: # shell
	$(INSTALL) fish
	chsh -s `which fish`

git: $(INSTALL) git # control version software

picom: $(INSTALL) picom # compositor for Xorg

polybar: # status bar
	$(INSTALL) polybar
	chmod +x ~/.config/polybar/launch.sh

ranger:	$(INSTALL) ranger # text based file manager

rofi: $(INSTALL) rofi # application launcher

dependencies: # basic dependencies
	$(INSTALL) util-linux-user # contains 'chsh' (i.e., change shell)
	$(INSTALL) aria2 # download manager
	$(INSTALL) wmname # utility to set name of window manager. Some java app have problems without it
