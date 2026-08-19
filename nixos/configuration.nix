{ config, pkgs, ... }: {
    # Include the results of the hardware scan.
    imports = [ ./hardware-configuration.nix ];

    # Enable nix experimental features.
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking.
    networking.hostName = "legion"; # Define your hostname.
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
 
    # Automatically setup second monitor
    systemd.user.services.autorandr = {
        enable = true;
        description = "Setup the second monitor";
        script = ''${pkgs.autorandr}/bin/autorandr home-setup'';
        wantedBy = [ "graphical-session.target" ];
        serviceConfig.Type = "oneshot";
        serviceConfig.PassEnvironment = "DISPLAY";
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    programs.zsh.enable = true;
    users.users.pbaldini = {
        isNormalUser = true;
        description = "Paolo Baldini";
        extraGroups = [ "networkmanager" "wheel" ];
        packages = with pkgs; [];
        shell = pkgs.zsh;
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        autorandr
        alacritty
        brightnessctl
        dunst
        gh
        git
        home-manager
        polybar
        ranger
        rofi
        oh-my-zsh
        scrot
        vim
        vivaldi
        wget
        xdo
    ];

    fileSystems."/mnt" = {
	device = "/dev/sda5";
    	fsType = "ext4";
    };

    # The NixOS release from which the default settings were taken; change with caution
    system.stateVersion = "26.05";
}
