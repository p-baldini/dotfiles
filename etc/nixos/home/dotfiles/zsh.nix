{ config, pkgs, ... }: {
    programs.zsh = {
        enable = true;
        enableCompletion = true;
        
        autosuggestion.enable = true;
        
        syntaxHighlighting.enable = true;
	
        oh-my-zsh = {
            enable = true;
	    theme = "mandrab";
            custom = "${config.xdg.configHome}/oh-my-zsh";
        };

        shellAliases = {
            la = "ls -al";
        };
    };
}
