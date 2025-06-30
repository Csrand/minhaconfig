{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";

    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    # Configuração do sistema NixOS
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./configuration.nix

        # Hyprland como módulo NixOS (não home-manager)
        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }

        # Home Manager integrado ao NixOS
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.csrand = import ./home.nix;
            extraSpecialArgs = {
              inherit inputs;
            };
          };
        }
      ];
    };

    # Home Manager standalone (caso você queira rodar `home-manager switch`)
    homeConfigurations.csrand = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  };
}
