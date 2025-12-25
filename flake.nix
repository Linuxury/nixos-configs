{
  description = "My modular multi-host NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, niri, ... }:
    let
      system = "x86_64-linux";

      hostModules = {
        # Display managers
        display.gdm          = ./modules/display/gdm.nix;
        display.cosmicGreeter= ./modules/display/cosmic-greeter.nix;

        # Desktop environments
        desktop.default      = ./modules/default.nix;  
        desktop.cosmic       = ./modules/desktop/cosmic.nix;
        desktop.gnome        = ./modules/desktop/gnome.nix;    
        desktop.kde          = ./modules/desktop/kde.nix;     
        desktop.hyprland     = ./modules/desktop/hyprland.nix;
        desktop.niri         = ./modules/desktop/niri.nix;

        # Host-specific modules
        host.laptop          = ./modules/host/laptop.nix;
        host.gaming          = ./modules/host/gaming.nix;

        # Snapper module
        snapper              = ./modules/snapper.nix;
      };
    in {
      nixosConfigurations = {
        ThinkPad = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit self hyprland niri home-manager;
            modules = hostModules;
          };
          modules = [ ./hosts/ThinkPad.nix ];
        };

        Ryzen5900x = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; modules = hostModules; };
          modules = [ ./hosts/Ryzen5900x.nix ];
        };

        Ryzen5800x = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; modules = hostModules; };
          modules = [ ./hosts/Ryzen5800x.nix ];
        };

        ASUSTuff-A15 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; modules = hostModules; };
          modules = [ ./hosts/ASUSTuff-A15.nix ];
        };

        Alex-Desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; modules = hostModules; };
          modules = [ ./hosts/Alex-Desktop.nix ];
        };

        Alex-Laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; modules = hostModules; };
          modules = [ ./hosts/Alex-Laptop.nix ];
        };

        generic = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; modules = hostModules; };
          modules = [ ./hosts/generic.nix ];
        };
      };
    };
}
