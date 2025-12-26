{ config, pkgs, lib, ... }:

{
  #########################
  # NVIDIA GPU performance
  #########################

  hardware.nvidia.modesetting.enable = true;

  environment.variables.NVIDIA_POWERMIZER = "0";  # max performance mode
  environment.systemPackages = with pkgs; [ nvtop ];
}
