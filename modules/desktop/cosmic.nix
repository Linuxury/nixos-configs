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
# Reliable WiFi management in COSMIC (native applet is immature)
#########################
networking.networkManager.enable = true;  # Should already be enabled somewhere, but ensure

# For password prompts/secrets in nm-applet
services.gnome.gnome-keyring.enable = true;

# Auto-start nm-applet tray icon in Wayland sessions (works great in COSMIC)
programs.nm-applet.enable = true;
];

  #########################
  # COSMIC Store + Flatpak
  #########################
  environment.systemPackages = with pkgs; [
    cosmic-store
    networkmanagerapplet
  ];
  services.flatpak.enable = true;
}
