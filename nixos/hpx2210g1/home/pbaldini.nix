{ config, pkgs, ... }: {
    # Home directory information
    home.username = "pbaldini";
    home.homeDirectory = "/home/pbaldini";
    home.stateVersion = "26.05";

    # User level installed packages
    home.packages = with pkgs; [
    ];

    # Import of application configuration files
    imports = [
        ./dotfiles/zsh.nix
    ];

    # Set up of environmental variables
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

    # Set up of XDG folder management and application autostart
    xdg.enable = true;
    xdg.autostart = {
        enable = true;
        entries = [
        ];
    };

    # Set up of XScreenSaver application
    services.xscreensaver.enable = true;
    home.file.".xscreensaver".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/.xscreensaver";

    # Set up background image
    home.file.".background-image".source = config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/.background-image";
}
