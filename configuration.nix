{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/users.nix
    ./modules/network.nix
    ./modules/sound.nix
    ./modules/graphics.nix
    ./modules/bluetooth.nix
    ./modules/wayland.nix 
  ];


  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # --- MONTAGEM DO HD DE STORAGE ---
  # Adicionado para montar seu HD de 465.8G em /storage.
  fileSystems."/storage" = {
    device = "/dev/disk/by-uuid/b9f358cd-9f43-4101-9752-6a31a580c2d2";
    fsType = "btrfs"; # Usando o tipo correto que você descobriu!
  };

  # Habilitar flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Versão do estado do sistema
  system.stateVersion = "25.05";
}
