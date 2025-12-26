{ config, pkgs, ... }:

{
  #########################
  # GNOME Display Manager
  #########################
  services.displayManager.gdm.enable = true;
  services.displayManager.gdm.wayland = true;

  #########################
  # Disable greetd/other greeters if present
  #########################
  services.displayManager.cosmic-greeter.enable = false;
}
