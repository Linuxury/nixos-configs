{ config, lib, pkgs, modules, ... }:

{
  #########################
  # Hardware configuration
  #########################
  imports = [
    modules.hardware-configuration.alex-desktop
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
    modules.host.performance-cpu
    modules.host.performance-amd    # AMD GPU
    # modules.host.performance-nvidia   # only if NVIDIA exists
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
  networking.hostName = "Alex-Desktop";

  #########################
  # Time & Locale
  #########################
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}
