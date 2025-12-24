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

  # Global fonts — available to all users on all machines
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols

    # Large curated Nerd Fonts set (most popular and useful — easy to add more names)
    # Find more names at https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/data/fonts/nerd-fonts/manifests/fonts.json
    (nerdfonts.override { fonts = [
      "FiraCode"
      "JetBrainsMono"
      "Hack"
      "Iosevka"
      "Meslo"
      "Ubuntu"
      "RobotoMono"
      "SourceCodePro"
      "Mononoki"
      "CascadiaCode"
      "Terminus"
      "DroidSansMono"
      "DejaVuSansMono"
      "NerdFontsSymbolsOnly"
      "0xProto"
      "Agave"
      "AnonymousPro"
      "Arimo"
      "AurulentSansMono"
      "BigBlueTerminal"
      "BitstreamVeraSansMono"
      "Bleach"
      "CodeNewRoman"
      "ComicShannsMono"
      "Cousine"
      "DaddyTimeMono"
      "DejaVuSansMono"
      "Go-Mono"
      "Gohu"
      "HeavyData"
      "Hermit"
      "Inconsolata"
      "InconsolataGo"
      "InconsolataLGC"
      "IntelOneMono"
      "Lekton"
      "LiberationMono"
      "Lilex"
      "MartianMono"
      "Moralerspace"
      "OpenDyslexic"
      "Overpass"
      "ProggyClean"
      "SpaceMono"
      "Tinos"
      "VictorMono"
      "ZedMono"
      # Add more names here if needed (no rebuild needed until you add)
    ]; })
  ];

  system.stateVersion = "25.11";
}
