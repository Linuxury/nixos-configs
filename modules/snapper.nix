{ config, pkgs, lib, ... }:

let
  cfg = config.services.snapper.configs.root;
in {
  # Snapper for root (@ subvol)
  services.snapper.configs.root = {
    SUBVOLUME = "/";
    ALLOW_USERS = [ "linuxury" ];
    TIMELINE_CLEANUP = true;
    TIMELINE_CREATE = true;
    TIMELINE_MIN_AGE = "1800";
    TIMELINE_LIMIT_HOURLY = "5";
    TIMELINE_LIMIT_DAILY = "7";
    TIMELINE_LIMIT_WEEKLY = "4";
    TIMELINE_LIMIT_MONTHLY = "3";
    TIMELINE_LIMIT_YEARLY = "1";
  };

  # Pre/post snapshots on nixos-rebuild
  services.snapper.autoSnapshot = true;
  services.snapper.autoSnapshot.flagged = "ext4";  # Use ext4 for compatibility, even on Btrfs

  # Cleanup old snapshots on boot
  boot.postBootCommands = ''
    ${pkgs.snapper}/bin/snapper --config root cleanup timeline
  '';

  # GRUB integration for rollback
  boot.loader.systemd-boot.configurationLimit = 20;
}
