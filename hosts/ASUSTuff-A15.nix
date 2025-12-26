{ config, lib, pkgs, modules, ... }:

{
  #########################
  # Hardware configuration
  #########################
  imports = [
    modules.hardware-configuration.asustuff-a15
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
    modules.host.performance-nvidia   # only uncomment if NVIDIA exists
  ];

  #########################
  # Users
  #########################
  imports = imports ++ [
    modules.users.babylinux
  ];

  #########################
  # Networking
  #########################
  networking.hostName = "ASUSTuff-A15";

  #########################
  # Time & Locale
  #########################
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}
