{ pkgs, ... }:

{
  imports = [
    ../hardware-configuration/thinkpad.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";  # ← Updated to your timezone
  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "us";

  hardware.cpu.amd.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true;

  swapDevices = [ { device = "/swap/swapfile"; } ];

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "yes";
      PasswordAuthentication = true;
    };
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # Default packages on EVERY machine — easy to add more here
  environment.systemPackages = with pkgs; [
    fastfetch
    fish
    ghostty
    firefox
    topgrade
    starship
    git
    # Add new global tools here later
  ];

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;

  # Global fonts — available to all users on all machines
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols

    # Curated Nerd Fonts (individual packages — lightweight & correct for unstable)
    # Easy to add more: just add e.g. nerd-fonts.hack
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    nerd-fonts.hack
    nerd-fonts.iosevka
    nerd-fonts.cascadia-code
    nerd-fonts.meslo
    nerd-fonts.ubuntu
    nerd-fonts.roboto-mono
    nerd-fonts.source-code-pro
    nerd-fonts.mononoki
  ];

  system.stateVersion = "25.11";
}
