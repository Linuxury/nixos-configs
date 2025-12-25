{ lib, config, pkgs, ... }:

{
  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };
}
