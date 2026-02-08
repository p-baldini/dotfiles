# Install essential packages
sudo pacman -S 7zip \
    alsa-utils \
    alacritty \
    antiword \
    base-devel \
    bspwm \
    docx2txt \
    dunst \
    fakeroot \
    feh \
    fontconfig \
    noto-fonts \
    odt2txt \
    patch \
    picom \
    polybar \
    ranger \
    rofi \
    scrot \
    sxhkd \
    unrar \
    xdo \
    xorg-xinput \
    zsh
yay -S \
    light

# Install work packages
sudo pacman -S \
    code \
    htop \
    make \
    texlive-core \
    tree

# Install 'oh-my-zsh'
yes n | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

