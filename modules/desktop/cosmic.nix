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
# NetworkManager applet for reliable WiFi in COSMIC
#########################
networking.networkManager.enable = true;  # Ensure NM is enabled (you probably already have this somewhere)

services.gnome.gnome-keyring.enable = true;  # Needed for password prompts/secrets

environment.systemPackages = with pkgs; [
  networkmanagerapplet  # nm-applet tray icon
];

# Auto-start nm-applet on COSMIC (Wayland) sessions
programs.nm-applet.enable = true;

  #########################
  # COSMIC Store + Flatpak
  #########################
  environment.systemPackages = with pkgs; [
    cosmic-store
  ];
  services.flatpak.enable = true;
}
