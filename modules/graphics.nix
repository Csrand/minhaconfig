{ config, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      libvdpau-va-gl
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };
 
  hardware.enableRedistributableFirmware = true;
 
  # Gerenciador de login
  services.xserver.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  }; 
}
