{ pkgs, inputs, ... }:

{
  imports = [
    ./modules/gtk.nix
    ./modules/hyprland.nix
    ./modules/terminal.nix
  ];

  # Configuração do Emacs/Doom
  home.packages = with pkgs; [
    # Pacote doom-emacs
    (pkgs.doom-emacs.override {
      doomPrivateDir = ./doom.d;  # Diretório com sua configuração
    })
    
    # Dependências essenciais
    git
    ripgrep
    fd
    emacs  # Emacs básico para fallback
  ];

  services.emacs = {
    enable = true;
    package = pkgs.doom-emacs;
    client = {
      enable = true;
      arguments = [ "-c" ];  # Abre em nova frame
    };
  };

  home.sessionVariables = {
    EDITOR = "emacsclient -c";
    VISUAL = "emacsclient -c";
  };

  # Seu resto de pacotes
  home.packages = with pkgs; [
    wget
    wl-clipboard
    waybar
    kitty
    swaylock
    networkmanagerapplet
    xdg-utils
    libsForQt5.qt5.qtwayland
    pavucontrol
    hyprpaper
    nerd-fonts.fira-code
    curl
    file
    neofetch
  ];

  home.username = "csrand";
  home.homeDirectory = "/home/csrand";
  home.stateVersion = "23.11";
}
