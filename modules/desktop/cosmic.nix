{ pkgs, ... }:

{
  # COSMIC desktop only (no greeter)
  services.desktopManager.cosmic.enable = true;

  # Required for graphical sessions
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
}
