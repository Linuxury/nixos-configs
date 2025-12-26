{ pkgs, lib, ... }:

{
  #########################
  # Hyprland Desktop Environment
  #########################
  services.xserver.enable = true;

  services.desktopManager.hyprland.enable = true;

  #########################
  # Hyprland Extras
  #########################
  environment.systemPackages = with pkgs; [
    hyprland
    waybar
    mako
    grim
    slurp
    wl-clipboard
    swaylock
    swayidle
    foot        # Terminal
    wayfire-git # Optional: Wayland compositor tools
  ];

  #########################
  # Wayland support
  #########################
  services.xserver.desktopManager.hyprland.wayland = true;

  #########################
  # Optional: user scripts or configs
  #########################
  # You can add per-user config files or global configs here if needed
}
