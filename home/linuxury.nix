{ pkgs, ... }:

{
  # Basic info
  home.username = "linuxury";
  home.homeDirectory = "/home/linuxury";

  # Compatibility version
  home.stateVersion = "25.11";

  # Personal packages (installed only for you, not system-wide)
  home.packages = with pkgs; [
    helix
    zed-editor
    # rustup python3 cargo packages etc. added later
  ];

  # Fish shell configuration
  programs.fish = {
    enable = true;

    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/Documents/GitRepos/nixos-configs#ThinkPad";
      hx = "helix";
      shx = "sudo -E helix";
      ll = "ls -l";
      la = "ls -la";
      topg = "topgrade";
      ff = "fastfetch";
      # Add more from your old dotfiles here
    };

    shellInit = ''
      # Greeting
      set -g fish_greeting ""

      # Run fastfetch on login
      fastfetch
    '';

    # Optional: plugins later (e.g., foreign-env, bass)
  };

  # Starship prompt
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = "$username$hostname$directory$git_branch$git_status$character";
      add_newline = false;
      # Customize further later (battery, time, etc.)
    };
  };

  # Ghostty terminal (basic config — expand later)
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "FiraCode";
      font-size = 13;
      background-opacity = 0.95;
      theme = "dark";
      cursor-style = "block";
      # Add your theme/keybindings later
    };
  };
}
