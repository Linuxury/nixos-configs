{ config, lib, pkgs, modules, inputs, jovianModule, ... }:

{
  #########################
  # Hardware configuration
  #########################
  imports = [
    modules.hardware-configuration.alex-laptop
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
    modules.host.laptop
    modules.host.gaming
    jovianModule
  ];

  #########################
  # Users
  #########################
  imports = imports ++ [
    modules.users.alex
  ];

  #########################
  # Networking
  #########################
  networking.hostName = "Alex-Laptop";

  #########################
  # Time & Locale
  #########################
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}


