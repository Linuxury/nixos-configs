{ pkgs, lib, ... }:

{
  #########################
  # LightDM Display Manager
  #########################
  environment.systemPackages = with pkgs; [ lightdm ];

  # Enable X server for graphical sessions
  services.xserver.enable = true;

  # Enable LightDM
  services.xserver.displayManager.lightdm.enable = true;
}
