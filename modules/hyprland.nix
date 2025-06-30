{ pkgs, inputs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    settings = {
      "$color_bg" = "0xff1E1E2E";
      "$color_fg" = "0xffCDD6F4";
      "$color_accent" = "0xff89B4FA";
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "$color_accent";
        "col.inactive_border" = "$color_bg";
      };
      decoration = {
        rounding = 8;
        blur = {
          enabled = true;
          size = 3;
          passes = 1;
        };
      };

      exec-once = [
        "alacritty"
        "waybar"
        "~/.config/hypr/scripts/wallpaper_switcher.sh &"
      ];
    };
    extraConfig = ''
      $mainMod = SUPER
      bind = $mainMod, Return, exec, alacritty
      bind = $mainMod SHIFT, Return, exec, alacritty --hold -e neofetch --ascii_distro nixos
      bind = $mainMod, Q, killactive
      bind = $mainMod SHIFT, F, exec, firefox
      bind = $mainMod SHIFT, Q, exit

      # Move focus with mainMod + vim keys
      bind = $mainMod, H, movefocus, l
      bind = $mainMod, L, movefocus, r
      bind = $mainMod, K, movefocus, u
      bind = $mainMod, J, movefocus, d

      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      bind = $mainMod, S, togglespecialworkspace, magic
      bind = $mainMod SHIFT, S, movetoworkspace, special:magic

      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow
    '';
  };


  # --- CONFIGURAÇÃO DO HYPRPAPER INICIA AQUI ---
  services.hyprpaper = {
    enable = true; # Habilita o daemon hyprpaper
    settings = {
      animation = "transition,500"; # Formato: "nome_da_animacao,duracao_ms"
      preload = "auto";
      ipc = true;
      splash = false;    
    };
  };  
}

