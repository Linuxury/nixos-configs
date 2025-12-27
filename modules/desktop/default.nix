{ pkgs, lib, ... }:

{
  #########################
  # Base packages
  #########################
  environment.systemPackages = with pkgs; [
    fastfetch
    fish
    ghostty
    firefox
    topgrade
    starship
    git
    gcc
    htop
    gnome-disk-utility  # for managing disks safely
    fluent-reader
    readest
    openrgb-with-all-plugins
  ];

  # Proper OpenRGB setup with AMD-specific i2c support
    services.hardware.openrgb = {
    enable = true;
    package = pkgs.openrgb-with-all-plugins;  # Uses the all-plugins variant
    motherboard = "amd";  # Loads i2c-piix4 module for SMBus access on AMD systems
  };

  #########################
  # Shell configuration
  #########################
  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/Documents/GitRepos/nixos-configs#ThinkPad";
      update  = "topgrade --only nix --only flatpak --only git_repos";
      cleanup = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      generations = "nix profile history --profile /nix/var/nix/profiles/system";

      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      home = "cd ~";
      docs = "cd ~/Documents";
      repos = "cd ~/Documents/GitRepos";

      hx = "helix";
      zed = "zed-editor";

      ff = "fastfetch";
      ls = "ls --color=auto -F";
      la = "ls -la";
      grep = "grep --color=auto";

      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";

      weather = "curl wttr.in";
      moon = "curl wttr.in/Moon";
      matrix = "cmatrix";
    };
    shellInit = ''
      set -g fish_greeting ""
      fastfetch
    '';
  };

  users.defaultUserShell = pkgs.fish;

  #########################
  # Fonts
  #########################
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    font-awesome
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  fonts.fontconfig.defaultFonts = {
    monospace  = [ "JetBrainsMono Nerd Font Mono" ];   # Terminals & code
    sansSerif  = [ "JetBrainsMono Nerd Font Propo" ];  # UI text
    serif      = [ "Noto Serif" ];                      # Fallback
  };

  #########################
  # Polkit (Privilege management)
  #########################
  security.polkit.enable = true;

  #########################
  # Bootloader configuration
  #########################
  boot.loader = {
    systemd-boot.enable = true;             # Use systemd-boot
    efi.canTouchEfiVariables = true;        # Allow NixOS to update EFI entries
    timeout = 0;                             # No delay, boot immediately
  };

  #########################
  # Kernel boot parameters
  #########################
  boot.kernelParams = [
    "quiet"           # Suppress standard boot messages
    "loglevel=0"      # Only show critical kernel messages
  ];

#########################
# SSH
#########################
services.openssh = {
  enable = true;
  settings = {
    PermitRootLogin = "no";       # or "yes" if you truly need it
    PasswordAuthentication = true;
  };
};


  #########################
  # System settings
  #########################
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "25.11";
}
