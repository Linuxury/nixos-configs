{ config, pkgs, lib, ... }:

{
  #########################
  # AMD GPU performance
  #########################

  # Optional AMD tweaks
  # environment.variables.AMD_POWER_PROFILE = "performance";  # if supported
  environment.systemPackages = with pkgs; [ radeontop ];
}
