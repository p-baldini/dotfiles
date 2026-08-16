{ config, pkgs, ... }:

{
    # Include the results of the hardware scan.
    imports = [ ./hardware-configuration.nix ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking.
    networking.hostName = "pbaldini-legion"; # Define your hostname.
    networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    networking.networkmanager.enable = true;

    # Set your time zone.
    time.timeZone = "Europe/Rome";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
        LC_ADDRESS = "it_IT.UTF-8";
        LC_IDENTIFICATION = "it_IT.UTF-8";
        LC_MEASUREMENT = "it_IT.UTF-8";
        LC_MONETARY = "it_IT.UTF-8";
        LC_NAME = "it_IT.UTF-8";
        LC_NUMERIC = "it_IT.UTF-8";
        LC_PAPER = "it_IT.UTF-8";
        LC_TELEPHONE = "it_IT.UTF-8";
        LC_TIME = "it_IT.UTF-8";
    };

    # Enable Nvidia proprietary drivers.
    #hardware.nvidia.open = false;
    #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
    #hardware.nvidia.modesetting.enable = true;
    #hardware.nvidia.nvidiaSettings = true;

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    # Configure GUI
    services.xserver.enable = true;
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.variant = "";
    services.xserver.windowManager.bspwm.enable = true;
    services.xserver.videoDrivers = [ "modesetting" ]; #[ "nvidia" ];
    services.displayManager.ly.enable = true;
    services.picom.enable = true;
    #     enable = true;
    #     fade = true;
    #     inactiveOpacity = 0.9;
    #     activeOpacity = 1.0;
    #     backend = "glx";
    #     vSync = true;
    # };
    services.udev.packages = [ pkgs.autorandr ];

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users."pbaldini" = {
        isNormalUser = true;
        description = "Paolo Baldini";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        autorandr
        alacritty
        #feh
        dunst
	gh
        git
        home-manager
        #libinput
        polybar
        ranger
        rofi
        oh-my-zsh
        scrot
        vim
        vivaldi
        vscode
        wget
        #xf86-video-fbdev
        steam
	xdo
        zsh
    ];
    environment.sessionVariables = {
	TERMINAL = "alacritty";
    };
    fileSystems."/mnt" = {
	device = "/dev/sda5";
    	fsType = "ext4";
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "26.05"; # Did you read the comment?

}
