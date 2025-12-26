{ pkgs, lib, ... }:

{
  #########################
  # COSMIC Greeter / Session
  #########################
  environment.systemPackages = with pkgs; [
    cosmic-greeter
  ];

  # Enable X server for graphical sessions
  services.xserver.enable = true;

  # Optional: allow COSMIC to manage its own session autostart
  services.xserver.windowManager.command = "${pkgs.cosmic}/bin/cosmic-session";
}
