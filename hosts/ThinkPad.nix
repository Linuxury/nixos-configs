{ config, lib, pkgs, modules, ... }:

let
  hwConfigPath = ./hardware-configuration.nix;
  hwConfigExists = builtins.pathExists hwConfigPath;
in
{
  imports = [
    (if hwConfigExists then import hwConfigPath else {})

    modules.display.gdm
    modules.desktop.common
    modules.desktop.cosmic
  ];

  networking.hostName = "ThinkPad";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}
