{ pkgs, lib, ... }:

{
  #########################
  # GNOME Desktop Environment
  #########################
  services.xserver.enable = true;

  services.desktopManager.gnome.enable = true;

  #########################
  # GNOME Extras / Tweaks
  #########################
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-terminal
    nautilus
    evince
    gnome-calculator
    gnome-system-monitor
    gnome-disk-utility
    flatpak
  ];

  #########################
  # Wayland support
  #########################
  services.xserver.desktopManager.gnome.wayland = true;
}
