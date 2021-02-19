.PHONY: install dependencies

# CONSTANTS

# dnf
INSTALL=sudo dnf install -y
GROUP_INSTALL=sudo dnf group install -y
REMOVE=sudo dnf remove -y
UPGRADE=sudo dnf upgrade -y

# linux
DOWNLOAD=`xdg-user-dir DOWNLOAD`
PICTURES=`xdg-user-dir PICTURES`

# BUILD RULES

install: dependencies alacritty audacity bitwarden bspwm dnf-faster feh fish git mailspring picom polybar ranger rofi

alacritty: # terminal emulator
	$(INSTALL) alacritty

# credits: http://pinguinetta.blogspot.com/2015/09/registrare-l-audio-di-sistema-con-linux.html
audacity: dependencies # audio editing
	$(INSTALL) --skip-broken alsa-lib "pulseaudio-*" paman paprefs pavucontrol pavumeter
	$(INSTALL) audacity-freeworld

bitwarden: dependencies # password manager
	sudo snap install bitwarden

bspwm: dependencies alacritty feh git picom polybar rofi # window manager
	git clone https://github.com/baskerville/bspwm.git $(DOWNLOAD)/bspwm
	git clone https://github.com/baskerville/sxhkd.git $(DOWNLOAD)/sxhkd
	$(INSTALL) xcb-util-devel xcb-util-keysyms-devel xcb-util-wm-devel alsa-lib-devel terminus-fonts # TODO maybe remove last
	$(GROUP_INSTALL) "Development Tools"
	cd $(DOWNLOAD)/bspwm; make; sudo make install; cd ..
	cd $(DOWNLOAD)/sxhkd; make; sudo make install; cd ..
	sudo chmod +x $(HOME)/.config/bspwm/bspwmrc
	rm -rf $(DOWNLOAD)/bspwm $(DOWNLOAD)/sxhkd

dnf-faster: dependencies # dnf patch based on aria
	git clone https://github.com/chitholian/DNF-Faster.git $(DOWNLOAD)/DNF-Faster
	patch -p0 -d/ -b < $(DOWNLOAD)/DNF-Faster/dnf-faster.patch
	cd $(HOME)
	rm -rf $(DOWNLOAD)/DNF-Faster

feh: dependencies # background manager
	$(INSTALL) feh
	aria2c -d $(PICTURES) https://upload.wikimedia.org/wikipedia/commons/0/0d/Great_Wave_off_Kanagawa2.jpg

fish: # shell
	$(INSTALL) fish
	chsh -s `which fish`
	sudo chsh -s `which fish`

git: # control version software
	$(INSTALL) git

mailspring: dependencies # email client
	sudo snap install mailspring

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
	$(UPGRADE)
	$(INSTALL) util-linux-user # contains 'chsh' (i.e., change shell)
	$(INSTALL) snapd # packaging and deployment system
	sudo snap wait system seed.loaded
	$(INSTALL) aria2 # download manager
	$(INSTALL) git # version control software
	$(INSTALL) patch # utility for modifying/upgrading files
	$(INSTALL) https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-`rpm -E %fedora`.noarch.rpm # rpm-fusion-free repo
	$(INSTALL) https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-`rpm -E %fedora`.noarch.rpm # rpm-fusion-non-free repo
