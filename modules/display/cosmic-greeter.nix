{ pkgs, lib, ... }:

{
  #########################
  # COSMIC Greeter / Session
  #########################
  services.displayManager.cosmic-greeter.enable = true;  
  
  environment.systemPackages = with pkgs; [
    cosmic-greeter
    cosmic-store
  ];

  # Enable X server only if you need X11 fallback (Wayland preferred)
  services.xserver.enable = lib.mkForce false;
}
