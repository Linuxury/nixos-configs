{ config, lib, pkgs, modules, inputs, ... }:

{
  #########################
  # Hardware configuration
  #########################
  imports = [
    modules.hardware-configuration.thinkpad
    modules.desktop.default
    modules.desktop.cosmic
    modules.display.gdm
    modules.host.laptop
    modules.host.gaming
    modules.host.coding
    modules.users.linuxury
    jovianModule
  ];

  #########################
  # Networking
  #########################
  networking.hostName = "ThinkPad";

  #########################
  # Time & Locale
  #########################
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}
