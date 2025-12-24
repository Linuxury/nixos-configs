{ ... }:

{
  imports = [
    ../modules/default.nix
    ../modules/cosmic.nix
    ../modules/snapper.nix
  ];

  networking.hostName = "ThinkPad";

  # Only your user on this machine
  users.users.linuxury = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme123";  # CHANGE SOON
  };

  security.sudo.wheelNeedsPassword = false;  # temporary
}
