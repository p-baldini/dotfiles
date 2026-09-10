{ config, pkgs, ... }: {
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            james-yu.latex-workshop
        ];
        userSettings = {
            "workbench.colorTheme" = "Quiet Light";
        };
    };
}
