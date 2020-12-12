.PHONY: install dependencies

# CONSTANTS

INSTALL=dnf install -y
GROUP_INSTALL=dnf group install -y
REMOVE=dnf remove

# BUILD RULES

install: dependencies alacritty audacity bitwarden dnf-faster fish git mailspring

alacritty: $(INSTALL) alacritty # terminal emulator

audacity: # audio editing
	$(INSTALL) libasound2-plugins "pulseaudio-*" paman paprefs pavucontrol pavumeter
	$(INSTALL) audacity-freeworld

bitwarden: dependencies # password manager
	snap install bitwarden

dnf-faster: dependencies # dnf patch based on aria
	git clone https://github.com/chitholian/DNF-Faster.git ~/Downloads/DNF-Faster
	cd ~/Downloads/DNF-Faster
	patch -p0 -d/ -b < dnf-faster.patch
	cd ~
	rm -rf ~/Downloads/DNF-Faster

fish: # shell
	$(INSTALL) fish
	chsh -s `which fish`
	rm ~/.bash*

git: $(INSTALL) git # control version software

mailspring: dependencies # email client
	snap install mailspring

dependencies: # basic dependencies
	$(INSTALL) util-linux-user # contains 'chsh' (i.e., change shell)
	$(INSTALL) snapd # packaging and deployment system
	$(INSTALL) aria2 # download manager
	$(INSTALL) git # version control software
	$(INSTALL) patch # utility for modifying/upgrading files
