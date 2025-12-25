{ config, lib, pkgs, modules, ... }:

let
  hwConfigPath = ./hardware-configuration.nix;
  hwConfigExists = builtins.pathExists hwConfigPath;
in
{
  imports = [
    # Only import hardware-configuration if it exists
    (if hwConfigExists then import hwConfigPath else {})

    # Global baseline system module (merged default + common)
    modules.default

    # Display manager
    modules.display.gdm

    # Desktop environment
    modules.desktop.cosmic
  ];

  networking.hostName = "ThinkPad";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}
