{ config, pkgs, lib, ... }:

{
  #########################
  # GDM Display Manager
  #########################
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
}
