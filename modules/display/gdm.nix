{ pkgs, lib, ... }:

{
  #########################
  # GDM Display Manager
  #########################
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;

  environment.systemPackages = with pkgs; [
    gdm
  ];
}
