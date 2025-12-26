{ pkgs, lib, ... }:

{
  #########################
  # COSMIC Greeter / Session
  #########################
  services.xserver.enable = true;

  environment.systemPackages = with pkgs; [
    cosmic-greeter
  ];

  # Let COSMIC manage its own session autostart
  services.xserver.windowManager.command = "${pkgs.cosmic}/bin/cosmic-session";
}
