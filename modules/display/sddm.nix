{ pkgs, lib, ... }:

{
  #########################
  # SDDM Display Manager
  #########################
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;

  environment.systemPackages = with pkgs; [
    sddm
  ];
}
