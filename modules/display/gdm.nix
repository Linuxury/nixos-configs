{ lib, ... }:

{
  services.greetd.enable = lib.mkForce false;

  services.xserver.enable = true;

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  # Safety: ensure no cosmic greeter leaks in
  services.displayManager.cosmic-greeter.enable = lib.mkForce false;
}
