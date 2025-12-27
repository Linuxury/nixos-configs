{ config, pkgs, lib, ... }:

{
  # Clean, quiet boot with graphical splash screen
  boot = {
    plymouth = {
      enable = true;
      # Choose a theme you like. "breeze" is clean and works well with COSMIC.
      # Alternatives: "spinner", "glow", "hexagon", or any from breeze-plymouth, adi1090x-plymouth, etc.
      theme = "breeze";
      themePackages = with pkgs; [
        # Ensures the breeze theme is available
        breeze-plymouth
      ];
    };

    # Hide verbose messages during stage-1 (initrd) and stage-2
    consoleLogLevel = 0;
    initrd.verbose = false;

    # Kernel parameters to suppress most console output
    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=auto"
      "rd.udev.log_priority=3"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"  # Hide blinking cursor
      "nowatchdog"                  # Disable hardware watchdog (eliminates "watchdog did not stop!" message)
    ];
  };

  # Speed up shutdown/reboot and disable software watchdog
  systemd = {
    extraConfig = ''
      # Reduce service stop timeout from default 90s to 10s
      DefaultTimeoutStopSec=10s
    '';

    watchdogs = {
      runtimeWatchdogSec = 0;
      rebootWatchdogSec = 0;
    };

    # Common source of shutdown delays – don't wait for network
    services.NetworkManager-wait-online.enable = false;
  };

  # Optional: If you ever see the watchdog message persist on Intel-based hardware (common on ThinkPads)
  # boot.blacklistedKernelModules = [ "iTCO_wdt" "sp5100_tco" ];
}
