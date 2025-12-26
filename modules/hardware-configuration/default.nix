{ config, lib, pkgs, ... }:

{

  #########################
  # Kernel modules
  #########################
  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  #########################
  # Root filesystem
  #########################
  fileSystems."/" = {
    device = "LABEL=nixos";
    fsType = "btrfs";
    options = [ "subvol=@" "compress=zstd:1" "noatime" "space_cache=v2" ];
  };

  fileSystems."/home" = {
    device = "LABEL=nixos";
    fsType = "btrfs";
    options = [ "subvol=@home" "compress=zstd:1" "noatime" "space_cache=v2" ];
  };

  fileSystems."/nix" = {
    device = "LABEL=nixos";
    fsType = "btrfs";
    options = [ "subvol=@nix" "compress=zstd:1" "noatime" "space_cache=v2" ];
  };

  fileSystems."/var/log" = {
    device = "LABEL=nixos";
    fsType = "btrfs";
    options = [ "subvol=@log" "compress=zstd:1" "noatime" "space_cache=v2" ];
  };

  fileSystems."/.snapshots" = {
    device = "LABEL=nixos";
    fsType = "btrfs";
    options = [ "subvol=@snapshots" "compress=zstd:1" "noatime" "space_cache=v2" ];
  };

  fileSystems."/swap" = {
    device = "LABEL=nixos";
    fsType = "btrfs";
    options = [ "subvol=@swap" ];
  };

  fileSystems."/boot" = {
    device = "LABEL=EFI";
    fsType = "vfat";
    options = [ "fmask=0022" "dmask=0022" ];
  };

  #########################
  # Swapfile
  #########################
  swapDevices = [
    { device = "/swap/swapfile"; }
  ];

  #########################
  # Platform defaults
  #########################
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
