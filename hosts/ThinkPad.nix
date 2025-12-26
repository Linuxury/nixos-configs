{ config, lib, pkgs, jovianModule ? null, ... }:

let
  optionalJovian = lib.optional (jovianModule != null) [ jovianModule.nixosModules.default ];
in {
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
  ] ++ optionalJovian;

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
