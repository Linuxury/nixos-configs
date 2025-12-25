{ lib, config, pkgs, ... }:

{
  options.display.cosmicGreeter.enable =
    lib.mkEnableOption "Enable COSMIC Greeter display manager";

  config = lib.mkIf config.display.cosmicGreeter.enable {
    services.displayManager.gdm.enable = lib.mkForce false;
    services.displayManager.cosmic-greeter.enable = true;
  };
}
