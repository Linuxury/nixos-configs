{ pkgs, lib, ... }:

{
  #########################
  # LightDM Display Manager
  #########################
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;

  environment.systemPackages = with pkgs; [
    lightdm
    lightdm-gtk-greeter
  ];
}
