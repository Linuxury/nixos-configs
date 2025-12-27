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
# Full NetworkManager setup for reliable WiFi (fixes unmanaged interfaces + conflicts)
#########################
networking.networkmanager.enable = true;                  # Enable NM
networking.wireless.enable = false;                       # Disable old wpa_supplicant (prevents conflicts)
networking.networkmanager.wifi.backend = "wpa_supplicant"; # Explicit backend (safe default)

# Force NM to manage ALL interfaces (common fix for "unmanaged" WiFi after enabling NM)
networking.networkmanager.unmanaged = [ ];

# Optional but recommended: Randomize MAC for privacy during scans (modern default)
networking.networkmanager.wifi.scanRandMacAddress = true;
}
