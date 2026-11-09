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
    hardware.nvidia.open = false;
    hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
    hardware.nvidia.modesetting.enable = true;
    hardware.nvidia.nvidiaSettings = true;
    hardware.nvidia.prime = {
        sync.enable = true; # Nvidia renders everything, Intel only drives the panel.
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
    };
    hardware.graphics.enable = true;
    hardware.graphics.enable32Bit = true;

    # Enable bluetooth hardware and services.
    hardware.bluetooth.enable = true;
    hardware.bluetooth.powerOnBoot = true;
    services.blueman.enable = true;

    # Configure GUI.
    services.xserver.enable = true;
    services.xserver.xkb.layout = "us";
    services.xserver.xkb.variant = "";
    services.xserver.windowManager.bspwm.enable = true;
    services.xserver.videoDrivers = [ "nvidia" ];
    services.xserver.dpi = 96; # Nvidia otherwise derives DPI from the external monitor's EDID (~81).
    services.xserver.desktopManager.runXdgAutostartIfNone = true;
    services.displayManager.ly.enable = true; # login manager.
    services.picom.enable = true;
 
    # Automatically setup second monitor.
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

    # Puts libraries loader at standard path for systems like conda and pixi to work.
    programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
            libGL
            stdenv.cc.cc.lib # libstdc++
            zlib
        ];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        alacritty       # terminal emulator
        autorandr       # display configurator
        brightnessctl   # brightness setter
        claude-code     # claude cli tool - note: much older version that what currently available
        cmake           # system builder
        dunst           # notification daemon
        gcc             # c compiler
        gh              # github cli tool
        gnumake         # control generation of non-source binaries
        git             # version control system
        home-manager    # user environment configurator
        htop            # processes overview
        oh-my-zsh       # zsh configurator
        p7zip           # archiver and extractor
        pamixer         # audio volume setter
        polybar         # status bar
        ranger          # file manager
        rofi            # application launcher
        scrot           # capture utility
        vim             # cli file editor
        vivaldi         # web browser
        wget            # file "downloader"
        xdo             # window actions
    ];

    # Enable zram compession.
    zramSwap.enable = true;

    # Automatically mount sda5 in mnt.
    fileSystems."/mnt" = {
	device = "/dev/sda5";
    	fsType = "ext4";
    };

    # Create a swap file of 32GB.
    swapDevices = [{
        device = "/var/lib/swapfile";
        size = 32 * 1024;
    }];

    # Avoids random screen state at startup.
    systemd.services.blank-fb1 = {
        description = "Blank secondary framebuffer";
        wantedBy = [ "display-manager.service" ];
        before = [ "display-manager.service" ];
        serviceConfig.Type = "oneshot";
        script = "[ -e /dev/fb1 ] && ${pkgs.coreutils}/bin/dd if=/dev/zero of=/dev/fb1 bs=1M 2>/dev/null || true";
    };

    # The NixOS release from which the default settings were taken; change with caution
    system.stateVersion = "26.05";
}
