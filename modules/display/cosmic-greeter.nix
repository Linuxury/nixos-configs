{ config, pkgs, lib, ... }:

{
  #########################
  # Cosmic Greeter
  #########################
  services.xserver.displayManager.cosmicGreeter.enable = true;
}
