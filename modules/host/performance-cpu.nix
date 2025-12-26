{ config, pkgs, lib, ... }:

{
  #########################
  # CPU performance tuning (Intel + AMD)
  #########################

  hardware.cpu.intel.updateMicrocode = true;
  hardware.cpu.amd.updateMicrocode   = true;

  boot.kernelParams = lib.mkForce [
    "intel_pstate=disable"  # ensures intel governor can be set manually
  ];

  systemd.services."set-cpu-governor" = {
    description = "Set CPU governor to performance on all cores";
    after = [ "multi-user.target" ];
    serviceConfig.Type = "oneshot";
    serviceConfig.ExecStart = ''
      for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
        echo performance > $cpu/cpufreq/scaling_governor
      done
    '';
    wantedBy = [ "multi-user.target" ];
  };

  vm.swappiness = 10;

  systemd.services."modemmanager.service".enable = lib.mkForce false;
  systemd.services."cups.service".enable = lib.mkForce false;

  environment.systemPackages = with pkgs; [
    htop
    iotop
    powertop
  ];
}
