{ config, pkgs, ... }: {
    # Include the results of the hardware scan.
    imports = [ ./hardware-configuration.nix ];

    # Enable nix experimental features.
    nix.settings.experimental-features = [ "nix-command" "flakes" ];

    # Bootloader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    # Networking.
    networking.hostName = "hpx2210g1"; # Define your hostname.
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

    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    # Configure GUI
    services.xserver.desktopManager.phosh = {
        enable = true;
        user = "pbaldini";
        group = "users";
    };    

    # Define a user account. Don't forget to set a password with ‘passwd’.
    programs.zsh.enable = true;
    users.users.pbaldini = {
        isNormalUser = true;
        description = "Paolo Baldini";
        extraGroups = [ "networkmanager" "wheel" ];
        #packages = with pkgs; [];
        shell = pkgs.zsh;
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        alacritty
        brightnessctl
        git
        home-manager
        oh-my-zsh
        vim
        vivaldi
        wget
        xdo
    ];

    # The NixOS release from which the default settings were taken; change with caution
    system.stateVersion = "26.05";

    # Add RAM swap to disk
    swapDevices = [{
        device = "/swapfile";
        size = 16 * 1024; # 16GB
    }];
}
