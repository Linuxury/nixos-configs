{ config, lib, pkgs, ... }:

let
  hwConfigPath = ./hardware-configuration.nix;
  hwConfigExists = builtins.pathExists hwConfigPath;
in
{
  imports = [
    # Import hardware configuration if it exists
    (if hwConfigExists then import hwConfigPath else {})

    # Display manager (safe default)
    ../modules/display/gdm.nix

    # Desktop foundation
    ../modules/desktop/common.nix

    # Default desktop (COSMIC)
    ../modules/desktop/cosmic.nix
  ];

  # Hostname (explicit)
  networking.hostName = "ThinkPad";

  # Allow flakes & nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Timezone
  time.timeZone = "America/New_York";

  # System version — DO NOT CHANGE once set
  system.stateVersion = "25.11";
}
