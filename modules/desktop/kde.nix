{ pkgs, lib, ... }:

{
  #########################
  # KDE Plasma 6 Desktop Environment
  #########################
  services.xserver.enable = true;

  # Enable Plasma 6 instead of plasma5
  services.desktopManager.plasma6.enable = true;

  #########################
  # KDE Essential Apps / Tweaks
  #########################
  environment.systemPackages = with pkgs; [
    konsole
    dolphin
    kate
    kdeconnect
    kdenlive
    okular
  ];
}
