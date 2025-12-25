{ pkgs, lib, ... }:

{
  # Cosmic Desktop Environment + native greeter
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # Required for Wayland/desktop
  services.xserver.enable = true;

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # COSMIC Store + Flatpak
  environment.systemPackages = with pkgs; [ cosmic-store ];
  services.flatpak.enable = true;

  # Fix greeter startup reliability (unstable quirk)
  systemd.services.cosmic-greeter = {
    wantedBy = lib.mkForce [ "graphical.target" ];
    restartIfChanged = true;
    serviceConfig.Restart = "always";
    serviceConfig.RestartSec = 3;
  };
}
