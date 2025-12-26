{ config, lib, pkgs, hostModules, ... }:

{
  #########################
  # Imports
  #########################
  imports = [
    hostModules.hardware-configuration.default

    hostModules.desktop.default
    hostModules.desktop.cosmic

    hostModules.display.gdm

    hostModules.host.performance-cpu
    hostModules.host.performance-amd
    hostModules.host.gaming
    hostModules.host.coding

    hostModules.users.babylinux
  ];

  #########################
  # Networking
  #########################
  networking.hostName = "Ryzen5800x";

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
