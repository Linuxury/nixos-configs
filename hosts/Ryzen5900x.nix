{ ... }:

{
  imports = [
    ../modules/default.nix
    ../modules/cosmic.nix
    ../modules/gaming.nix    # ← Gaming enabled here
    ../modules/snapper.nix   # Optional: enable on desktop too
  ];

  networking.hostName = "Ryzen5900x";

  # Your user on this machine
  users.users.linuxury = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "gamemode" ];
    initialPassword = "changeme123";
  };

  security.sudo.wheelNeedsPassword = false;

  # Hardware-specific (RX 7900 XTX + Ryzen 9 5900X)
  boot.kernelParams = [ "amd_iommu=on" "iommu=pt" ];
  hardware.cpu.amd.updateMicrocode = true;
}
