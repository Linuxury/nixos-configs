{ config, lib, pkgs, hostModules, jovianModule ? null, ... }:

{
  #########################
  # Hardware configuration
  #########################
  imports = [
    hostModules.hardware-configuration.thinkpad
    hostModules.desktop.default
    hostModules.desktop.cosmic
    hostModules.display.gdm
    hostModules.host.laptop
    hostModules.host.gaming
    hostModules.host.coding
    hostModules.users.linuxury
  ] ++ lib.optional (jovianModule != null) [ jovianModule.default ];

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
