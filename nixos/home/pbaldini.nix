{ config, pkgs, ... }: {
    home.username = "pbaldini";
    home.homeDirectory = "/home/pbaldini";
    home.stateVersion = "26.05";

    imports = [
        ./dotfiles/zsh.nix
    ];

    home.sessionVariables = {
        BROWSER = "${pkgs.vivaldi}/bin/vivaldi";
        EDITOR = "${pkgs.vim}/bin/vim";
        GUI_EDITOR = "${pkgs.code}/bin/code";
        HISTFILE = "${config.xdg.stateHome}/bash/history";
        TERMINAL = "${pkgs.alacritty}/bin/alacritty";
        VISUAL = "${pkgs.code}/bin/code";
    };

    xdg.enable = true;
}
