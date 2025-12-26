{ config, pkgs, lib, jovianModule ? null, ... }:

{
  #########################
  # Gaming tools
  #########################
  programs.steam.enable = true;

  # 32-bit support for old games
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

  # Gamemode (performance boost)
  programs.gamemode.enable = true;

  # Packages 
  environment.systemPackages = with pkgs; [
    mangohud
    protonplus
    gamescope
    lutris
    wineWowPackages.stable
    winetricks
    goverlay
    lsfg-vk
    lsfg-vk-ui
    faugus-launcher
    mcpelauncher-ui-qt
    mcpelauncher-client
  ];

  #########################
  # Decky Loader (Jovian)
  #########################
  # Only include overlay and enable service if jovianModule is provided
  nixpkgs.overlays = lib.mkIf (jovianModule != null) [
    jovianModule.overlay
  ];

  services.decky-loader.enable = lib.mkIf (jovianModule != null) true;

  #########################
  # AMD-specific tweaks
  #########################
  hardware.opengl.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  #########################
  # Unfree packages
  #########################
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
  ];

  #########################
  # Firewall / networking for gaming (example)
  #########################
  networking.firewall.allowedTCPPorts = [ 27015 27036 ];
  networking.firewall.allowedUDPPorts = [ 27015 27036 ];
}
