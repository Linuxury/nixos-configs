{ config, lib, pkgs, ... }:

{
  # Enable graphical stack
  services.xserver.enable = true;

  # Wayland + XWayland support
  programs.xwayland.enable = true;

  # Sound (modern, stable default)
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Basic fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
  ];

  # Input
  services.libinput.enable = true;

  # Portals (required for Wayland desktops)
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };
}
