{ config, lib, pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.displayManager.cosmic-greeter.enable = false;
}
