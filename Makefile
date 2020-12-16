.PHONY: install dependencies

# CONSTANTS

# dnf
INSTALL=sudo dnf install -y
GROUP_INSTALL=sudo dnf group install -y
REMOVE=sudo dnf remove -y
UPGRADE=sudo dnf upgrade -y

# linux
DOWNLOAD=`xdg-user-dir DOWNLOAD`

# BUILD RULES

install: dependencies alacritty audacity bitwarden dnf-faster fish git mailspring ranger

alacritty: # terminal emulator
	$(INSTALL) alacritty

# credits: http://pinguinetta.blogspot.com/2015/09/registrare-l-audio-di-sistema-con-linux.html
audacity: dependencies # audio editing
	$(INSTALL) --skip-broken alsa-lib "pulseaudio-*" paman paprefs pavucontrol pavumeter
	$(INSTALL) audacity-freeworld

bitwarden: dependencies # password manager
	sudo snap install bitwarden

dnf-faster: dependencies # dnf patch based on aria
	git clone https://github.com/chitholian/DNF-Faster.git $(DOWNLOAD)/DNF-Faster
	patch -p0 -d/ -b < $(DOWNLOAD)/DNF-Faster/dnf-faster.patch
	cd $(HOME)
	rm -rf $(DOWNLOAD)/DNF-Faster

fish: # shell
	$(INSTALL) fish
	chsh -s `which fish`
	sudo chsh -s `which fish`
	rm $(HOME)/.bash*

git: # control version software
	$(INSTALL) git

mailspring: dependencies # email client
	sudo snap install mailspring

ranger: dependencies # text based file manager
	$(INSTALL) ranger
	sudo aria2c -d /usr/share/pixmaps -o ranger.png https://upload.wikimedia.org/wikipedia/commons/e/e4/Ranger_logo.png

dependencies: # basic dependencies
	$(UPGRADE)
	$(INSTALL) util-linux-user # contains 'chsh' (i.e., change shell)
	$(INSTALL) snapd # packaging and deployment system
	$(INSTALL) aria2 # download manager
	$(INSTALL) git # version control software
	$(INSTALL) patch # utility for modifying/upgrading files
	$(INSTALL) https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-`rpm -E %fedora`.noarch.rpm # rpm-fusion-free repo
	$(INSTALL) https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-`rpm -E %fedora`.noarch.rpm # rpm-fusion-non-free repo
