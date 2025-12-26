{ config, pkgs, lib, ... }:

{
#########################
# Coding tools
#########################
environment.systemPackages = with pkgs; [
  python310      # Python 3.10 (or pkgs.python310Full if you want full stdlib)
  python310Packages.pip
  rustc          # Rust compiler
  cargo          # Rust package manager
  zed-editor
  helix
  neovim
  git
  tree
];


  #########################
  # Python environment
  #########################
  programs.python = {
    enable = true;
    packages = ps: with ps; [
      numpy
      pandas
      requests
      black
      mypy
    ];
  };

  #########################
  # Rust environment
  #########################
  programs.rust = {
    enable = true;
    cargoHome = "/home/linuxury/.cargo";
  };
}
