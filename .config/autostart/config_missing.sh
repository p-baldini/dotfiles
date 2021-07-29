#!/bin/sh
# Install zsh plugins

ZSH_CUSTOM=~/.local/share/oh-my-zsh/custom
mkdir -p $ZSH_CUSTOM/plugins/

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions/" ]]; then
	git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting/" ]]; then
	git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi
