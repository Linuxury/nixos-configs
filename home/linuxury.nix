{ pkgs, ... }:

{
  home.username = "linuxury";
  home.homeDirectory = "/home/linuxury";

  home.stateVersion = "25.11";

  # Your personal packages (only for you)
  home.packages = with pkgs; [
    helix
    zed-editor
    # Add more personal tools later (rustup, python, etc.)
  ];

  # Starship (optional — can stay per-user if you want custom theme)
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      format = "$username$hostname$directory$git_branch$git_status$character";
      # Customize your theme here
    };
  };
}
