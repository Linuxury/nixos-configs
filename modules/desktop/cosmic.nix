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

  environment.systemPackages = with pkgs; [
    cosmic-store
    networkmanagerapplet  # For reliable WiFi tray icon (COSMIC native applet is still buggy)
  ];

  #########################
  # Reliable WiFi management in COSMIC
  #########################
  # Ensure NetworkManager is enabled (add if not present elsewhere)
  networking.networkManager.enable = true;

  # Needed for nm-applet secret/password handling
  services.gnome.gnome-keyring.enable = true;

  # Auto-start nm-applet tray indicator (works great on COSMIC/Wayland)
  programs.nm-applet.enable = true;
  programs.nm-applet.indicator = true;  # Modern indicator style (recommended)
}
