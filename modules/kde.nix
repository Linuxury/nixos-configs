{ pkgs, ... }:

{
  # KDE Plasma 6
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Required for KDE apps
  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.kate
    kdePackages.okular
    # Add more KDE apps if wanted
  ];
}
