{ config, lib, pkgs, ... }:

{
  imports = [
    # Existing hardware configuration
    ./hardware-configuration.nix

    # Display manager (safe default)
    ../modules/display/gdm.nix

    # Desktop foundation
    ../modules/desktop/common.nix

    # Default desktop (COSMIC)
    ../modules/desktop/cosmic.nix
  ];

  # Hostname (keep explicit)
  networking.hostName = "ThinkPad";

  # Allow flakes & nix-command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Timezone (example; keep or change if already set elsewhere)
  time.timeZone = "America/New_York";

  # System version — DO NOT CHANGE once set
  system.stateVersion = "24.05";
}

