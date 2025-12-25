{ config, lib, pkgs, modules, ... }:

let
  hwConfigPath = ./hardware-configuration.nix;
  hwConfigExists = builtins.pathExists hwConfigPath;
in
{
  imports = [
    (if hwConfigExists then import hwConfigPath else {})

    # Correct paths inside modules
    modules.hardware-configuration.thinkpad
    modules.desktop.default
    modules.display.gdm
    modules.desktop.cosmic
  ];

  users.users.linuxury = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    password = "changeme";  # can hash later
    shell = pkgs.fish;
  };

  networking.hostName = "ThinkPad";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}
