{ home-manager, ... }:

{
  imports = [
    ../modules/default.nix
    ../modules/cosmic.nix
    ../modules/snapper.nix
    ../modules/laptop.nix
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.linuxury = import ../home/linuxury.nix;
    }
  ];

  networking.hostName = "ThinkPad";

  users.users.linuxury = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme123";
  };

  security.sudo.wheelNeedsPassword = false;
}
