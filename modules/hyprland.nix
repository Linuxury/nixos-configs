{ inputs, pkgs, ... }:

{
  # Hyprland Wayland compositor
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  # Required for Wayland apps
  security.polkit.enable = true;

  environment.systemPackages = with pkgs; [
    waybar
    rofi-wayland
    dunst
    # Add your Hyprland config later in Home Manager
  ];
}
