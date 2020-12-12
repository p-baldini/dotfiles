.PHONY: install dependencies

# CONSTANTS

INSTALL=dnf install -y
GROUP_INSTALL=dnf group install -y
REMOVE=dnf remove

# BUILD RULES

install: dependencies alacritty audacity bitwarden fish git mailspring

alacritty: $(INSTALL) alacritty # terminal emulator

audacity: # audio editing
	$(INSTALL) libasound2-plugins "pulseaudio-*" paman paprefs pavucontrol pavumeter
	$(INSTALL) audacity-freeworld

bitwarden: dependencies # password manager
	snap install bitwarden

fish: # shell
	$(INSTALL) fish
	chsh -s `which fish`

git: $(INSTALL) git # control version software

mailspring: dependencies # email client
	snap install mailspring

dependencies: # basic dependencies
	$(INSTALL) util-linux-user # contains 'chsh' (i.e., change shell)
	$(INSTALL) snapd # packaging and deployment system
