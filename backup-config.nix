{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Habilitar flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  # Usuário
  users.users.csrand = {
    isNormalUser = true;
    description = "csrand";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "audio" ];
  };

  # Sistema de som
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Drivers gráficos (Intel)
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };

  # Variáveis de ambiente para Wayland
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  # Pacotes essenciais
  environment.systemPackages = with pkgs; [
    wget
    git
    wl-clipboard
    waybar
    kitty
    swaybg
    swaylock
    networkmanagerapplet
    xdg-utils
    libsForQt5.qt5.qtwayland
    pavucontrol # Controle de áudio
  ];

  # Gerenciador de login
  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  # Configuração do console
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Ativar suporte a firmware
  hardware.enableRedistributableFirmware = true;

  system.stateVersion = "25.05";
}
