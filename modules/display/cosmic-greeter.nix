{ pkgs, lib, ... }:

{
  #########################
  # Cosmic Greeter (greetd)
  #########################
  services.displayManager.cosmic-greeter.enable = true;

  # Required for Wayland/desktop
  services.xserver.enable = true;

  #########################
  # Sound & multimedia
  #########################
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #########################
  # Fix greeter startup reliability
  #########################
  systemd.services.cosmic-greeter = {
    wantedBy = lib.mkForce [ "graphical.target" ];
    restartIfChanged = true;
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 3;
  };
}
