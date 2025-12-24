{ ... }:

{
  imports = [
    ../modules/default.nix
  ];

  networking.hostName = "nixos-generic";

  # Only a neutral admin user — no personal users or dotfiles
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme";
  };

  security.sudo.wheelNeedsPassword = false;
}
