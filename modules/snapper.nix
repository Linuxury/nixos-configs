{ pkgs, lib, ... }:

{
  # Enable Btrfs quotas on boot (required for Snapper)
  boot.initrd.postDeviceCommands = lib.mkBefore ''
    ${pkgs.btrfs-progs}/bin/btrfs quota enable /
  '';

  # Snapper config for root subvolume
  services.snapper = {
    snapshotInterval = "hourly";
    cleanupInterval = "1d";

    configs.root = {
      SUBVOLUME = "/";
      FSTYPE = "btrfs";
      SPACE_LIMIT = "0.5";  # Optional: limit snapshot space to 50%
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

  # Clean boot menu
  boot.loader.systemd-boot.configurationLimit = 30;
}
