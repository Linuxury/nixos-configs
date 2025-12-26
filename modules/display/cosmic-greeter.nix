{ pkgs, lib, ... }:

{
  #########################
  # COSMIC Greeter
  #########################
  environment.systemPackages = with pkgs; [ cosmic-greeter ];

  # Ensure X server is available for graphical sessions
  services.xserver.enable = true;
}
