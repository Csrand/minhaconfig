{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
    catppuccin.url = "github:catppuccin/nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, hyprland, nix-doom-emacs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      # REMOVIDO overlays com nix-doom-emacs porque não existe overlay nesse flake
    };
  in {
    # Configuração do sistema NixOS
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      system = system;
      specialArgs = {
        inherit inputs;
      };
      modules = [
        ./configuration.nix
        hyprland.homeManagerModules.default
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

    # Home Manager standalone (para rodar `home-manager switch`)
    homeConfigurations.csrand = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [ ./home.nix ];
      extraSpecialArgs = {
        inherit inputs;
      };
    };
  };
}
