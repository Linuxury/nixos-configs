{ pkgs, lib, ... }:

{
  #########################
  # Niri Desktop Environment
  #########################
  services.xserver.enable = true;

  services.desktopManager.niri.enable = true;

  #########################
  # Niri Extras
  #########################
  environment.systemPackages = with pkgs; [
    niri
    niri-widgets
    niri-tools
    foot         # Terminal emulator
    waybar       # Status bar for Wayland
    mako         # Notifications
    grim
    slurp
    wl-clipboard
  ];

  #########################
  # Wayland support
  #########################
  services.xserver.desktopManager.niri.wayland = true;

  #########################
  # Optional: user scripts or configs
  #########################
  # You can add global Niri configs or user scripts here
}
