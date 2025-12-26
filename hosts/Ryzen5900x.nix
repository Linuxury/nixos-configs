{ config, lib, pkgs, modules, inputs, jovianModule, ... }:

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
    modules.host.coding
    modules.host.performance-cpu
    modules.host.performance-amd    # uncomment if AMD GPU exists
    # modules.host.performance-nvidia   # only on hosts with NVIDIA
    jovianModule
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
