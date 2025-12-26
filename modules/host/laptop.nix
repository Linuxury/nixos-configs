{ pkgs, lib, ... }:

{
  #########################
  # Laptop-specific configuration
  #########################

  #########################
  # Power Management
  #########################
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

      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "auto";

      USB_AUTOSUSPEND = 1;
    };
  };

  # Disable power-profiles-daemon to prevent conflict with TLP
  services.power-profiles-daemon.enable = lib.mkForce false;

  #########################
  # Thermal Management
  #########################
  services.thermald.enable = true;

  #########################
  # Lid & Suspend Behavior
  #########################
  services.logind.lidSwitch = "suspend";
  services.logind.lidSwitchExternalPower = "suspend";
  services.logind.lidSwitchDocked = "ignore";

  #########################
  # Input Devices
  #########################
  services.libinput.enable = true;
  services.libinput.touchpad.naturalScrolling = true;
  services.libinput.touchpad.tapping = true;

  #########################
  # Extra Tools
  #########################
  environment.systemPackages = with pkgs; [
    acpi
    powertop
  ];
}
