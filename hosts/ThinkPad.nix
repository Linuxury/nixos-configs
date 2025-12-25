{ config, lib, pkgs, self, ... }:

let
  hwConfigPath = ./hardware-configuration.nix;
  hwConfigExists = builtins.pathExists hwConfigPath;
in
{
  imports = [
    # Conditional hardware config
    (if hwConfigExists then import hwConfigPath else {})

    # Display manager
    self.modules.display.gdm

    # Desktop foundation
    self.modules.desktop.common

    # Default desktop
    self.modules.desktop.cosmic
  ];

  networking.hostName = "ThinkPad";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  time.timeZone = "America/New_York";

  system.stateVersion = "25.11";
}
