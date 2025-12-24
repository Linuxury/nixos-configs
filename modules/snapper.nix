{ pkgs, ... }:

{
  # Snapper for root subvolume (@)
  services.snapper = {
    configs.root = {
      SUBVOLUME = "/";
      ALLOW_USERS = [ "linuxury" ];
      TIMELINE_CLEANUP = true;
      TIMELINE_CREATE = true;
      TIMELINE_MIN_AGE = "1800";
      TIMELINE_LIMIT_HOURLY = "8";
      TIMELINE_LIMIT_DAILY = "7";
      TIMELINE_LIMIT_WEEKLY = "4";
      TIMELINE_LIMIT_MONTHLY = "1";
      TIMELINE_LIMIT_YEARLY = "1";
    };

    # Auto snapshots on nixos-rebuild (pre/post)
    autoSnapshot = true;
    autoSnapshotCleanup = true;

    # Cleanup on boot
    cleanupTimer = true;
  };

  # Limit systemd-boot entries for clean GRUB menu
  boot.loader.systemd-boot.configurationLimit = 30;
}
