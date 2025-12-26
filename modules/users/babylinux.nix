{ config, pkgs, lib, ... }:

{
  users.users.babylinux = {
    isNormalUser = true;
    # Optional description; keep private or local-only
    description = "Milagros Monserrate"; 
    extraGroups = [ "wheel" "networkmanager" "docker" "video" "audio" ];
    password = "changeme"; # optionally hashed with mkpasswd
    shell = pkgs.fish;
  };
}
