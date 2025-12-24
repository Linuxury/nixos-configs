{ pkgs, ... }:

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

  # COSMIC Store (App Store for COSMIC apps/Flatpaks)
  environment.systemPackages = with pkgs; [
    cosmic-store
  ];

  # Flatpak support — required for COSMIC Store to manage Flatpaks
  services.flatpak.enable = true;
}
