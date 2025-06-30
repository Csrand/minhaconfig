{ pkgs,inputs, ... }:

{
  home.file.".config/neofetch/config.conf".text = ''
    print_info() {
      prin " NixOS"
      info " Distro" distro
      info " Kernel" kernel
      info "󰍛 RAM" memory
      info "󰁿" Battery" battery  
  }
    title_fqdn="off"
    kernel_shorthand="on"
    memory_percent="on"
    memory_unit="gib"
    separator=" → "
  '';
}
