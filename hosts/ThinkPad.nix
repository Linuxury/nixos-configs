{ ... }:

{
  imports = [
    ../modules/default.nix
    ../modules/cosmic.nix
    # Optional DEs — uncomment only when you want them on this machine
    # ../modules/hyprland.nix
    # ../modules/niri.nix
    # ../modules/kde.nix
  ];

  networking.hostName = "ThinkPad";

  # Your personal users
  users.users.linuxury = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme123";  # CHANGE SOON
  };

  users.users.babylinux = {
    isNormalUser = true;
    initialPassword = "changeme123";
  };

  users.users.alex = {
    isNormalUser = true;
    initialPassword = "changeme123";
  };

  # Temporary convenience — disable later
  security.sudo.wheelNeedsPassword = false;
}
