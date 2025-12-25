{ pkgs, ... }:

{
  imports = [
    ../hardware-configuration/thinkpad.nix
  ];

  # Latest kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

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

  # Base packages for EVERY machine
  environment.systemPackages = with pkgs; [
    fastfetch
    fish
    ghostty
    firefox
    topgrade
    starship
    git
    # Add more base tools here later
  ];

  # Global fish config (aliases for all users)
  programs.fish = {
    enable = true;
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#ThinkPad";
      update = "topgrade --only nix --only flatpak --only git_repos";
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

  # Global fonts
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

  # System-wide default fonts
  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font Mono" ];   # Terminals & code
    sansSerif = [ "JetBrainsMono Nerd Font Propo" ];  # UI text (panels, menus, apps)
    serif = [ "Noto Serif" ];                         # Fallback serif
  };

  system.stateVersion = "25.11";
}
