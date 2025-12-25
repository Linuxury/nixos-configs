{ config, lib, pkgs, ... }:

{
  services.displayManager.gdm.enable = false;

  services.displayManager.cosmic-greeter.enable = true;
}
