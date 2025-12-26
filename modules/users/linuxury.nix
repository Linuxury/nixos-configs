{ config, pkgs, lib, ... }:

{
  users.users.linuxury = {
    isNormalUser = true;
    # Optional description; keep private or local-only
    description = "Erick Rodriguez"; 
    extraGroups = [ "wheel" "networkmanager" "docker" "video" "audio" ];
    password = "changeme"; # optionally hashed with mkpasswd
    shell = pkgs.fish;
  };
}
