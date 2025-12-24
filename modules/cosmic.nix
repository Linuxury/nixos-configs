{ pkgs, lib, ... }:

{
  # Cosmic Desktop Environment + native greeter
  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;

  # Required for Wayland/desktop in general
  services.xserver.enable = true;

  # Sound (PipeWire)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # COSMIC Store
  environment.systemPackages = with pkgs; [
    cosmic-store
  ];

  # Flatpak support for COSMIC Store
  services.flatpak.enable = true;

  # Ensure cosmic-greeter starts on boot (override for unstable quirks)
  systemd.services.cosmic-greeter = {
    wantedBy = [ "graphical.target" ];
    after = [ "graphical.target" ];
  };
}
