# Install essential packages
sudo pacman -S 7zip \
    alacritty \
    antiword \
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
    zsh

# Install work packages
sudo pacman -S \
    htop \
    make \
    texlive-core

# Install 'oh-my-zsh'
yes n | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

