{ pkgs, lib, ... }:

{
  #########################
  # GNOME Desktop Environment
  #########################
  services.xserver.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  #########################
  # GNOME Extensions / Tweaks
  #########################
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extensions-app
  ];

  #########################
  # Optional GNOME apps
  #########################
  environment.systemPackages = environment.systemPackages ++ with pkgs; [
    evince        # PDF reader
    gedit         # Text editor
    nautilus      # File manager
    gnome-terminal
  ];
}
