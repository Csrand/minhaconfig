{ pkgs, inputs, ... }:

{
  home.username = "csrand";
  home.homeDirectory = "/home/csrand";
  home.stateVersion = "23.11";

  

  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Compact-Blue-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = ["blue"];
        size = "compact";
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders;
    };
  };

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
        drop_shadow = false;
      };
      exec-once = [
        "swaybg -i ${pkgs.catppuccin-gtk}/share/backgrounds/Catppuccin/macchiato.png"
        "alacritty --hold -e neofetch --ascii_distro nixos"
        "waybar"
      ];
    };
    extraConfig = ''
      $mainMod = SUPER
      bind = $mainMod, Return, exec, alacritty
      bind = $mainMod SHIFT, Return, exec, alacritty --hold -e neofetch --ascii_distro nixos
      bind = $mainMod, Q, killactive
      bind = $mainMod SHIFT, F, exec, firefox

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
 

  programs.fish = {
   enable = true;
  };
  
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "none";
        padding = { x = 5; y = 5; };
      };
      font = {
        size = 11;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
      };
      colors = {
        primary = {
          background = "0x1E1E2E";
          foreground = "0xCDD6F4";
        };
        cursor = {
          text = "0x1E1E2E";
          cursor = "0xF5E0DC";
        };
        normal = {
          black = "0x45475A";
          red = "0xF38BA8";
          green = "0xA6E3A1";
          yellow = "0xF9E2AF";
          blue = "0x89B4FA";
          magenta = "0xF5C2E7";
          cyan = "0x94E2D5";
          white = "0xBAC2DE";
        };
      };
    };
  };

  home.file.".config/neofetch/config.conf".text = ''
    print_info() {
      prin " NixOS"
      info " Distro" distro
      info " Kernel" kernel
      info "󰍛 RAM" memory
    }
    title_fqdn="off"
    kernel_shorthand="on"
    memory_percent="on"
    memory_unit="gib"
    separator=" → "
  '';

  home.file.".doom.d" = {
    source = ./doom-config;
    recursive = true;
  };

  programs.emacs = {
    enable = true;
    package = pkgs.emacsNativeComp;
    extraPackages = epkgs: [ epkgs.vterm ];
  };

  home.packages = with pkgs; [
    vim
    fish
    catppuccin-gtk
    catppuccin-papirus-folders
    alacritty
    neofetch
    swaybg
    nerd-fonts.fira-code
    git
    ripgrep
    fd
    clang
    gnumake
    wget
    curl
    file
    waybar 
 ];
}
