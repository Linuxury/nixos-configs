{ pkgs, lib, ... }:

{
  #########################
  # Coding tools
  #########################
  environment.systemPackages = with pkgs; [
    python310
    python310Packages.pip
    rustc
    cargo
    helix
    zed-editor
    neovim
    git
    tree
  ];

  #########################
  # Shell
  #########################
  programs.fish.enable = true;
}
