{ config, lib, pkgs, modules, ... }:

{
imports = [
  modules.hardware-configuration.thinkpad
  modules.desktop.default
  modules.display.gdm
  modules.desktop.cosmic
  modules.users.linuxury
];

  networking.hostName = "ThinkPad";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}

