{ config, pkgs, ... }: {
    home.username = "pbaldini";
    home.homeDirectory = "/home/pbaldini";
    home.stateVersion = "26.05";

    home.packages = with pkgs; [
        steam
        thunderbird
        vscode
    ];

    imports = [
        ./dotfiles/zsh.nix
    ];

    home.sessionVariables = {
        BROWSER = "${pkgs.vivaldi}/bin/vivaldi";
        EDITOR = "${pkgs.vim}/bin/vim";
        GUI_EDITOR = "${pkgs.vscode}/bin/code";
        HISTFILE = "${config.xdg.stateHome}/history";
        TERMINAL = "${pkgs.alacritty}/bin/alacritty";
        VISUAL = "${pkgs.vscode}/bin/code";
        XCOMPOSECACHE = "${config.xdg.cacheHome}/X11/xcompose";
        ZDOTDIR = "${config.xdg.configHome}/zsh";
    };

    xdg.enable = true;

    services.xscreensaver.enable = true;
    home.file.".xscreensaver".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/.xscreensaver";
}
