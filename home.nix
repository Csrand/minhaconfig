{ pkgs, inputs, ... }:

let
  doomEmacs = inputs.nix-doom-emacs.packages.x86_64-linux.default.override {
    doomPrivateDir = ./doom.d;  # Seu config Doom
  };
in {
  imports = [
    ./modules/gtk.nix
    ./modules/terminal.nix
    ./modules/hyprland.nix
  ];

  home.username = "csrand";
  home.homeDirectory = "/home/csrand";
  home.stateVersion = "23.11";

  programs.emacs = {
    enable = true;
    package = doomEmacs;  # Agora usa o pacote correto
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
