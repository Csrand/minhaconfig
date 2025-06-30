{ config, pkgs, ... }:

{
  users.users.csrand = {
    isNormalUser = true;
    description = "csrand";
    extraGroups = [ "networkmanager" "wheel" "video" "input" "audio" ];
  };
}
