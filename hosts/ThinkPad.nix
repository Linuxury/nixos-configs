{ config, pkgs, lib, jovianModule ? null, ... }:

{
  #########################
  # Hardware configuration
  #########################
  imports = [
    ../modules/hardware-configuration/thinkpad.nix
    ../modules/desktop/default.nix
    ../modules/desktop/cosmic.nix
    ../modules/display/gdm.nix
    ../modules/host/laptop.nix
    ../modules/host/gaming.nix
    ../modules/host/coding.nix
    ../modules/users/linuxury.nix
  ];

  #########################
  # Optional Decky Loader
  #########################
  nixpkgs.overlays = lib.mkIf (jovianModule != null) [ jovianModule.overlay ];
  services.decky-loader.enable = lib.mkIf (jovianModule != null) true;

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
