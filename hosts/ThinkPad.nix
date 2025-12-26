{ config, lib, pkgs, ... , jovianModule ? null }:

let
  # Optional reference to jovianModule overlay
  enableDecky = jovianModule != null;
in
{
  #########################
  # Hardware configuration
  #########################
  imports = [
    ./modules/hardware-configuration/thinkpad.nix
    ./modules/desktop/default.nix
    ./modules/desktop/cosmic.nix
    ./modules/display/gdm.nix
    ./modules/host/laptop.nix
    ./modules/host/gaming.nix
    ./modules/host/coding.nix
    ./modules/users/linuxury.nix
  ] ++ lib.optional enableDecky [ jovianModule.default ];

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
