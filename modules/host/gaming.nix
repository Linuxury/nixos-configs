{ pkgs, lib, ... }:

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

  # MangoHud (FPS overlay)
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
  # Decky Loader (Steam Deck plugin loader)
  #########################

  jovian.decky-loader.enable = true;

  # Optional: add extra deps
  jovian.decky-loader.extraPackages = [
    pkgs.python3
    pkgs.flatpak
  ];

  #########################
  # AMD-specific tweaks
  #########################
  hardware.opengl.extraPackages = with pkgs; [
    # amdvlk
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
  networking.firewall.allowedTCPPorts = [ 27015 27036 ]; # example ports
  networking.firewall.allowedUDPPorts = [ 27015 27036 ];
}
