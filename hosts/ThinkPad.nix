{ config, lib, pkgs, modules, ... }:

{
  imports = [
    modules.hardware-configuration.thinkpad
    modules.desktop.default
    modules.display.gdm
    modules.desktop.cosmic
  ];

  networking.hostName = "ThinkPad";

  users.users.linuxury = {
    isNormalUser = true;
    description = "Main user";
    extraGroups = [ "wheel" "networkmanager" "docker" ];
    shell = pkgs.fish;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  time.timeZone = "America/New_York";
  system.stateVersion = "25.11";
}
