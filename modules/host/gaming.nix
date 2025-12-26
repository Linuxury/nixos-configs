{ config, lib, pkgs, modules, ... }:

{
  #########################
  # Gaming configuration
  #########################

  #########################
  # Steam + Proton
  #########################
  programs.steam = {
    enable = true;
    remotePlay.openPorts = true;
    dedicatedServer.openPorts = true;
    gamescopeSession.enable = true;  # Gamescope for FSR, windowed fullscreen
  };

  #########################
  # 32-bit support for old games
  #########################
  hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  hardware.pulseaudio.support32Bit = true;

#########################
# Gaming tools
#########################
environment.systemPackages = with pkgs; [
  mangohud
  gamemode
  protonup-qt           # Manage Proton-GE
  gamescope
  lutris                # For non-Steam games
  wineWowPackages.stable  # Wine for Windows games
  winetricks
  # Optional: add heroic-games-launcher, bottles later
];


  #########################
  # AMD-specific tweaks (RX 7900 XTX)
  #########################
  hardware.opengl.extraPackages = with pkgs; [
    amdvlk
    rocmPackages.clr.icd
  ];

  #########################
  # Allow unfree packages
  #########################
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-run"
  ];
}
