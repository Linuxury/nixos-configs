{ inputs, pkgs, ... }:

{
  # Niri scrolling tiling Wayland compositor
  programs.niri.enable = true;

  environment.systemPackages = with pkgs; [
    # Basic tools for Niri
    waybar
    wofi
  ];
}
