{ config, pkgs, lib, ... }:

{
  users.users.alex = {
    isNormalUser = true;
    # Optional description; keep private or local-only
    description = "Alexander Rodriguez"; 
    extraGroups = [ "wheel" "networkmanager" "docker" "video" "audio" ];
    password = "changeme"; # optionally hashed with mkpasswd
    shell = pkgs.fish;
  };
}
