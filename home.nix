{ pkgs, inputs, ... }:

{
  imports = [
    ./modules/gtk.nix
    ./modules/terminal.nix
    ./modules/hyprland.nix
    inputs.nix-doom-emacs.hmModule
  ];

  home.username = "csrand";
  home.homeDirectory = "/home/csrand";
  home.stateVersion = "23.11";

  programs.doom-emacs = {
    enable = true;
    doomPrivateDir = ./doom.d;
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    VISUAL = "emacsclient -c";
  };

  home.packages = with pkgs; [
    # Essential Doom Emacs dependencies
    binutils
    gnutls
    zlib
    emacs-all-the-icons-fonts
    
    # Your existing packages
    git ripgrep fd
    (aspellWithDicts (d: with d; [ en en-computers en-science ]))
    wget wl-clipboard waybar kitty swaylock networkmanagerapplet
    xdg-utils libsForQt5.qt5.qtwayland
    pavucontrol hyprpaper
    nerd-fonts.fira-code
    curl file neofetch
  ];
}
