{ config, pkgs, lib, ... }:

{
  #########################
  # Cosmic Greeter
  #########################
  # services.xserver.displayManager.cosmicGreeter.enable = true;
  environment.systemPackages = with pkgs; [ cosmic-greeter ];
}
