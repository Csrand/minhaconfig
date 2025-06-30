{
  description = "My NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    catppuccin.url = "github:catppuccin/nix";
    doom-emacs = {
      url = "github:vlaci/nix-doom-emacs";
      flake = false;  # IMPORTANTE: Indica que não é um flake completo
    };
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, doom-emacs, hyprland, emacs-overlay, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        emacs-overlay.overlays.default
        (final: prev: {
          doom-emacs = prev.callPackage doom-emacs {};
        })
      ];
    };
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit pkgs;
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.csrand = import ./home.nix;
            extraSpecialArgs = { 
              inherit inputs;
              doom-emacs = pkgs.doom-emacs;  # Passa o pacote para home.nix
            };
          };
        }
      ];
    };

    homeConfigurations."csrand" = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      extraSpecialArgs = { 
        inherit inputs;
        doom-emacs = pkgs.doom-emacs;  # Passa o pacote para home.nix
      };
      modules = [ ./home.nix ];
    };
  };
}
