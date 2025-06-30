{ config, pkgs, ... }:

{

 #Variáveis de ambiente para Wayland

   environment.sessionVariables = {
     WLR_NO_HARDWARE_CURSORS = "1";
     NIXOS_OZONE_WL = "1";
     GDK_BACKEND = "wayland";
     QT_QPA_PLATFORM = "wayland";
     SDL_VIDEODRIVER = "wayland";
     CLUTTER_BACKEND = "wayland";
  };
}
