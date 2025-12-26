{ config, lib, pkgs, hostModules, ... }:

{
  #########################
  # Imports
  #########################
  imports = [
    hostModules.hardware-configuration.default

    hostModules.desktop.default
    hostModules.desktop.cosmic

    hostModules.display.cosmic-greeter

    hostModules.host.laptop
    hostModules.host.gaming
    hostModules.host.coding
    hostModules.host.performance-amd

    hostModules.users.linuxury
  ];

  #########################
  # Networking
  #########################
  networking.hostName = "ThinkPad";

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
