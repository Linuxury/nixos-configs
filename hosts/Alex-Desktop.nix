{ config, lib, pkgs, hostModules, ... }:

{
  #########################
  # Imports
  #########################
  imports = [
    hostModules.hardware-configuration.default

    hostModules.desktop.default
    hostModules.desktop.cosmic

    hostModules.display.cosmicGreeter

    hostModules.host.laptop
    hostModules.host.gaming

    hostModules.users.alex
  ];

  #########################
  # Networking
  #########################
  networking.hostName = "Alex-Desktop";

  #########################
  # Time & Locale
  #########################
  time.timeZone = "America/New_York";

  #########################
  # System state version
  #########################
  system.stateVersion = "25.11";

  #########################
  # Nix experimental features
  #########################
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
