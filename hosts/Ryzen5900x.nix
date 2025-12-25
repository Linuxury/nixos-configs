{ config, lib, pkgs, modules, ... }:

{
  #########################
  # Hardware configuration
  #########################
  imports = [
    modules.hardware-configuration.ryzen5900x
  ];

  #########################
  # Desktop environments
  #########################
  imports = imports ++ [
    modules.desktop.default
    modules.desktop.cosmic
  ];

  #########################
  # Display manager
  #########################
  imports = imports ++ [
    modules.display.gdm
  ];

  #########################
  # Host-specific modules
  #########################
  imports = imports ++ [
    modules.host.gaming
  ];

  #########################
  # Users
  #########################
  imports = imports ++ [
    modules.users.linuxury
  ];

  #########################
  # Networking
  #########################
  networking.hostName = "Ryzen5900x";

  #########################
  # Time & Locale
  #########################
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}
