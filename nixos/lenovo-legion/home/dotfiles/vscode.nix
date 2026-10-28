{ config, pkgs, ... }: {
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            james-yu.latex-workshop
            anthropic.claude-code
        ];
        userSettings = {
            # VSCode color theme.
            "workbench.colorTheme" = "Quiet Light";

            # Claude extension setup.
            "claudeCode.preferredLocation" = "panel";
            "claudeCode.hideOnboarding" = true;
        };
    };
}
