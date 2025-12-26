{ config, pkgs, lib, ... }:

{
  #########################
  # Coding / Developer tools
  #########################

  environment.systemPackages = with pkgs; [
    python310Full
    python310Packages.pip
    python310Packages.virtualenv
    rustc
    cargo
    fd         # Faster file search
    ripgrep    # Fast grep alternative
    make
    cmake
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
