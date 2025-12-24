{ pkgs, ... }:

{
  # TLP — advanced power management
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;

      START_CHARGE_THRESH_BAT0 = 75;  # Start charging when below 75%
      STOP_CHARGE_THRESH_BAT0 = 80;   # Stop charging when reaching 80%

      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      USB_AUTOSUSPEND = 1;
    };
  };

  # Thermald — prevent CPU/GPU overheating
  services.thermald.enable = true;

  # Auto-suspend on lid close
  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchExternalPower = "suspend";
  services.logind.lidSwitchDocked = "ignore";

  # Better touchpad support
  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = true;
  services.libinput.touchpad.tapping = true;

  # Power profiles daemon (for Cosmic power widget)
  services.power-profiles-daemon.enable = true;

  # Extra laptop packages
  environment.systemPackages = with pkgs; [
    acpi           # Battery info
    powertop       # Power analysis
    auto-cpufreq   # Optional CPU frequency scaling (alternative to TLP)
  ];

  # Enable auto-cpufreq as fallback (optional, comment out if TLP is enough)
  # services.auto-cpufreq.enable = true;
}
