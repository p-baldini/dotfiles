{
    description = "Paolo Baldini's NixOS flake configuration";

    # The nixpkgs entry in the flake registry.
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
        home-manager = {
            url = "github:nix-community/home-manager/release-26.05";
            inputs.nixpkgs.follows = "nixpkgs"; # avoids collisions of pkgs versions
        };
    };

    outputs = { nixpkgs, home-manager, ... }@inputs: {
        nixosConfigurations.legion = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./lenovo-legion/configuration.nix
                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.backupFileExtension = "backup";

                    home-manager.users.pbaldini.imports = [ ./lenovo-legion/home/pbaldini.nix ];
                }
            ];
        };
        nixosConfigurations.hpx2210g1 = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hpx2210g1/configuration.nix
                home-manager.nixosModules.home-manager {
                    home-manager.useGlobalPkgs = true;
                    home-manager.useUserPackages = true;
                    home-manager.backupFileExtension = "backup";

                    home-manager.users.pbaldini.imports = [ ./hpx2210g1/home/pbaldini.nix ];
                }
            ];
        };

    };
}
