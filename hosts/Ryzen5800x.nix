{ ... }:

{
  imports = [
    ../modules/default.nix
    ../modules/cosmic.nix
    ../modules/snapper.nix   # Optional
    ../modules/gaming.nix    # Optional if she wants gaming
  ];

  networking.hostName = "Ryzen5800x";

  # Wife's user
  users.users.babylinux = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme123";
  };

  security.sudo.wheelNeedsPassword = false;
}
