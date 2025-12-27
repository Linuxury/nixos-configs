{ pkgs, lib, ... }:

{
  #########################
  # COSMIC Desktop
  #########################
  services.desktopManager.cosmic.enable = true;

  #########################
  # Graphical session support
  #########################
  services.xserver.enable = true;

  #########################
  # Sound
  #########################
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  #########################
  # COSMIC Store + Flatpak
  #########################
  services.flatpak.enable = true;

  #########################
  # COSMIC packages + nm-applet for reliable WiFi
  #########################
  environment.systemPackages = with pkgs; [
    cosmic-store
    networkmanagerapplet  # Reliable WiFi tray icon (COSMIC native applet is still immature/buggy on unstable)
  ];

  #########################
  # Enable NetworkManager (fixes WiFi visibility in applets)
  #########################
  # networking.networkmanager.enable = true;  # Correct lowercase 'm'

  #########################
  # Required for nm-applet password prompts/secrets
  #########################
  # services.gnome.gnome-keyring.enable = true;

  #########################
  # Auto-start nm-applet tray icon (works perfectly in COSMIC/Wayland)
  #########################
  # programs.nm-applet.enable = true;
  # programs.nm-applet.indicator = true;  # Modern indicator style (recommended for COSMIC)
}
