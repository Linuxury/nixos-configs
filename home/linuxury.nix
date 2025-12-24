{ pkgs, ... }:

{
  home.username = "linuxury";
  home.homeDirectory = "/home/linuxury";

  home.stateVersion = "25.11";

  # Personal packages (only for you)
  home.packages = with pkgs; [
    helix
    zed-editor
    rustup
    cargo
    python3
    # Add more when needed (e.g., node, go, etc.)
  ];

  # Fish — clean, modern config
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      # Clean greeting
      set -g fish_greeting

      # Run fastfetch on login
      fastfetch

      # Better history
      set -g fish_history_size 10000
    '';

    # Enhanced aliases (clean, useful)
    shellAliases = {
      # System
      rebuild = "sudo nixos-rebuild switch --flake ~/Documents/GitRepos/nixos-configs#ThinkPad";
      update = "topgrade";
      cleanup = "sudo nix-collect-garbage -d && nix-collect-garbage -d";

      # Navigation
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      home = "cd ~";
      docs = "cd ~/Documents";
      repos = "cd ~/Documents/GitRepos";

      # Tools
      ff = "fastfetch";
      hx = "helix";
      zed = "zed-editor";
      ls = "ls --color=auto -F";
      la = "ls -la";
      lt = "ls --tree";
      grep = "grep --color=auto";

      # Git
      g = "git";
      gs = "git status";
      ga = "git add";
      gc = "git commit -v";
      gp = "git push";
      gl = "git pull";
      gd = "git diff";
      glg = "git log --oneline --graph --decorate";

      # Fun
      weather = "curl wttr.in";
      moon = "curl wttr.in/Moon";
    };

    # Optional: plugins (uncomment when wanted)
    # plugins = [
    #   { name = "foreign-env"; src = pkgs.fishPlugins.foreign-env.src; }
    # ];
  };

  # Starship — modern prompt
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      format = "$username$hostname$directory$git_branch$git_status$nix_shell$character";
      username = {
        show_always = true;
        style_user = "bold blue";
        format = "[$user]($style) ";
      };
      hostname = {
        ssh_only = false;
        style = "bold green";
        format = "@[$hostname]($style) ";
      };
      directory = {
        truncation_length = 4;
        truncate_to_repo = true;
        style = "bold purple";
      };
      git_branch = {
        style = "bold yellow";
      };
      nix_shell = {
        symbol = "❄️ ";
        format = "[$symbol]($style)";
      };
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };

  # Ghostty — clean config with Nerd Font
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = 13;
      background-opacity = 0.95;
      theme = "dark";
      cursor-style = "block";
      window-decoration = false;  # Clean look in Cosmic
      shell-integration = "fish";
    };
  };

  # Helix — basic config (expand later)
  programs.helix = {
    enable = true;
    settings = {
      theme = "dark_plus";
      editor = {
        line-number = "relative";
        cursorline = true;
        color-modes = true;
      };
    };
  };
}
