.PHONY: install dependencies

# CONSTANTS

# dnf
INSTALL=sudo dnf install -y
GROUP_INSTALL=sudo dnf group install -y
REMOVE=sudo dnf remove

# linux
DOWNLOAD=`xdg-user-dir DOWNLOAD`
PICTURES=`xdg-user-dir PICTURES`

# BUILD RULES

install: dependencies alacritty bspwm feh fish git picom polybar ranger rofi

alacritty: # terminal emulator
	$(INSTALL) alacritty

bspwm: dependencies alacritty feh git picom polybar rofi # window manager
	git clone https://github.com/baskerville/bspwm.git $(DOWNLOAD)/bspwm
	git clone https://github.com/baskerville/sxhkd.git $(DOWNLOAD)/sxhkd
	$(INSTALL) xcb-util-devel xcb-util-keysyms-devel xcb-util-wm-devel alsa-lib-devel terminus-fonts # TODO maybe remove last
	$(GROUP_INSTALL) "Development Tools"
	cd $(DOWNLOAD)/bspwm; make; make install; cd ..
	cd $(DOWNLOAD)/sxhkd; make; make install; cd ..
	sudo chmod +x $(HOME)/.config/bspwm/bspwmrc
	rm -rf $(DOWNLOAD)/bspwm $(DOWNLOAD)/sxhkd

feh: dependencies # background manager
	$(INSTALL) feh
	aria2c -d $(PICTURES) https://upload.wikimedia.org/wikipedia/commons/0/0d/Great_Wave_off_Kanagawa2.jpg

fish: # shell
	$(INSTALL) fish
	chsh -s `which fish`
	sudo chsh -s `which fish`

git: # control version software
	$(INSTALL) git

picom: # compositor for Xorg
	$(INSTALL) picom

polybar: # status bar
	$(INSTALL) polybar
	chmod +x $(HOME)/.config/polybar/launch.sh

ranger: dependencies # text based file manager
	$(INSTALL) ranger
	sudo aria2c -d /usr/share/pixmaps -o ranger.png https://upload.wikimedia.org/wikipedia/commons/e/e4/Ranger_logo.png

rofi: # application launcher
	$(INSTALL) rofi

dependencies: # basic dependencies
	$(INSTALL) util-linux-user # contains 'chsh' (i.e., change shell)
	$(INSTALL) aria2 # download manager
	$(INSTALL) wmname # utility to set name of window manager. Some java app have problems without it
