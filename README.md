# NixOS system setup

The repository is intended to be cloned in the XDG_CONFIG_HOME directory of your home -- usually, `.config`.

Once cloned, you can run your nixos installation by using flakes:
```
sudo nixos-rebuild switch --flake $HOME/.config#legion # or $XDG_CONFIG_HOME if already set  
```
This will install are relevant files and packages in your system.

## TODO list:
- separate configuration.nix in files per topic and in home-managed data;
- updated package dependencies;
- adapt usage of scrot to the new bar; evaluate inclusion as rofi script;
- check used manjaro conf files present in the repo and remove them.
