{ pkgs, inputs, ... }:

{
  imports = [
    ./modules/gtk.nix
    ./modules/hyprland.nix
    ./modules/terminal.nix
  ];

  home.username = "csrand";
  home.homeDirectory = "/home/csrand";
  home.stateVersion = "23.11";

  # Editor principal: Doom Emacs
  programs.emacs = {
    enable = true;
    package = pkgs.doom-emacs;  # Usa o pacote que você passou pelo flake
  };

  services.emacs = {
    enable = true;
    client.enable = true;
  };

  home.file.".doom.d" = {
    source = ./doom.d;
    recursive = true;
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    VISUAL = "emacsclient -c";
    DOOMDIR = "$HOME/.doom.d";
  };

  home.packages = with pkgs; [
    git ripgrep fd
    (aspellWithDicts (d: with d; [ en en-computers en-science ]))
    wget wl-clipboard waybar kitty swaylock networkmanagerapplet
    xdg-utils libsForQt5.qt5.qtwayland
    pavucontrol hyprpaper
    nerd-fonts.fira-code
    curl file neofetch
  ];
}
