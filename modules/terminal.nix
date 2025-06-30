{ pkgs,inputs, ... }:

{
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
}
