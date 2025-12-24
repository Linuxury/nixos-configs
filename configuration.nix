{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "ThinkPad";
  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";  # ← CHANGE THIS TO YOUR ACTUAL TIMEZONE
  i18n.defaultLocale = "en_US.UTF-8";

  console.keyMap = "us";  # or your layout, e.g. "de", "uk"

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  swapDevices = [ { device = "/swap/swapfile"; } ];

  environment.systemPackages = with pkgs; [
    fastfetch fish ghostty starship topgrade zed firefox
  ];

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  users.users.linuxury = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "changeme123";  # CHANGE THIS AFTER FIRST LOGIN
  };

  users.users.babylinux = {
    isNormalUser = true;
    initialPassword = "changeme123";
  };

  users.users.alex = {
    isNormalUser = true;
    initialPassword = "changeme123";
  };

  security.sudo.wheelNeedsPassword = false;  # optional – remove if you want password prompt

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.11";
}
