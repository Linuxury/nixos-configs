{ pkgs, lib, ... }:

{
  #########################
  # SDDM Display Manager
  #########################
  environment.systemPackages = with pkgs; [ sddm ];

  # Enable X server for graphical sessions
  services.xserver.enable = true;

  # Enable SDDM
  services.xserver.displayManager.sddm.enable = true;
}
