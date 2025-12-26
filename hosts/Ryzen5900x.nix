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

    hostModules.host.performance-cpu
    hostModules.host.performance-amd
    hostModules.host.gaming
    hostModules.host.coding

    hostModules.users.linuxury
  ];

  #########################
  # Networking
  #########################
  networking.hostName = "Ryzen5900x";

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
