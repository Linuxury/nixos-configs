{ config, pkgs, ... }:
{
  boot = {
    plymouth = {
      enable = true;
      theme = "breeze";  # Simple default; or try "spinner", "nixos-logo" etc. from nixpkgs
    };
    consoleLogLevel = 0;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "systemd.show_status=auto"
      "udev.log_priority=3"
      "rd.udev.log_priority=3"
      "vt.global_cursor_default=0"  # Hides cursor too
    ];
  };
}
