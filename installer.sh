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
    texlive-binextra \
    texlive-core \
    texlive-fontsextra \
    texlive-lang \
    texlive-latex \
    texlive-latexextra \
    texlive-latexrecommended \
    texlive-plaingeneric \
    tree
yay -S \
    urw-classico

# Install 'oh-my-zsh'
yes n | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Add user to video group (light tool)
sudo usermod -a -G video $USER

