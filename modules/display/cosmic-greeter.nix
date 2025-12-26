{ config, pkgs, lib, ... }:

{
  #########################
  # Cosmic greeter (example)
  #########################
  services.xserver.displayManager.cosmic.enable = true;
}
