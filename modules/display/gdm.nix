{ pkgs, lib, ... }:

{
  #########################
  # GDM Display Manager
  #########################
  environment.systemPackages = with pkgs; [ gdm ];

  # Enable X server for graphical sessions
  services.xserver.enable = true;

  # Enable GDM
  services.xserver.displayManager.gdm.enable = true;
}
