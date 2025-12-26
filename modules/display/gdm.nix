{ config, pkgs, lib, ... }:

{
  #########################
  # Display manager
  #########################
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}
