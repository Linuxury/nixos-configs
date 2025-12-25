{ ... }:

{
  imports = [
    ../modules/default.nix
    ../modules/cosmic.nix
    # ../modules/snapper.nix   # Optional
  ];

  networking.hostName = "Alex-Desktop";

  # Kid's user
  users.users.alex = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" ];
    initialPassword = "changeme123";
  };

  # No sudo for kid (remove wheel group if wanted)
  security.sudo.wheelNeedsPassword = false;
}
