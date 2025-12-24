{ ... }:

{
  imports = [
    ../modules/default.nix
    ../modules/cosmic.nix
    ../modules/snapper.nix
    ../modules/laptop.nix   # ← NEW: power management
  ];

  networking.hostName = "ThinkPad";

  users.users.linuxury = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme123";
  };

  security.sudo.wheelNeedsPassword = false;
}
