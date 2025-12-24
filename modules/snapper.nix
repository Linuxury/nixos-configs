{ pkgs, ... }:

{
  # Snapper for root subvolume (@)
  services.snapper = {
    snapshotInterval = "hourly";   # Auto snapshots every hour
    cleanupInterval = "1d";        # Cleanup old snapshots daily

    configs.root = {
      SUBVOLUME = "/";
      FSTYPE = "btrfs";
      ALLOW_USERS = [ "linuxury" ];
      TIMELINE_CREATE = true;
      TIMELINE_CLEANUP = true;
      TIMELINE_MIN_AGE = "1800";
      TIMELINE_LIMIT_HOURLY = "8";
      TIMELINE_LIMIT_DAILY = "7";
      TIMELINE_LIMIT_WEEKLY = "4";
      TIMELINE_LIMIT_MONTHLY = "1";
      TIMELINE_LIMIT_YEARLY = "1";
    };
  };

  # Limit systemd-boot entries for clean boot menu
  boot.loader.systemd-boot.configurationLimit = 30;
}
