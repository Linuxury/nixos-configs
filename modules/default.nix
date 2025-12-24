{ pkgs, ... }:

{
  imports = [
    ../hardware-configuration/thinkpad.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

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

  # Global fonts — basic set (Nerd Fonts removed for now)
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
  ];

  system.stateVersion = "25.11";
}
