{
  description = "My modular multi-host NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    jovian.url = "github:Jovian-Experiments/Jovian-NixOS";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";
    niri.url = "github:sodiboo/niri-flake";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, niri, jovian, ... }:
  let
    system = "x86_64-linux";

    hostModules = {
      # Hardware configuration
      hardware-configuration.thinkpad = ./modules/hardware-configuration/thinkpad.nix;

      # Display managers
      display.gdm           = ./modules/display/gdm.nix;
      display.cosmicGreeter = ./modules/display/cosmic-greeter.nix;

      # Desktop environments
      desktop.default   = ./modules/desktop/default.nix;
      desktop.cosmic    = ./modules/desktop/cosmic.nix;
      desktop.gnome     = ./modules/desktop/gnome.nix;
      desktop.kde       = ./modules/desktop/kde.nix;
      desktop.hyprland  = ./modules/desktop/hyprland.nix;
      desktop.niri      = ./modules/desktop/niri.nix;

      # Host-specific modules
      host.laptop            = ./modules/host/laptop.nix;
      host.gaming            = ./modules/host/gaming.nix;
      host.coding            = ./modules/host/coding.nix;
      host.performance-cpu   = ./modules/host/performance-cpu.nix;
      host.performance-amd   = ./modules/host/performance-amd.nix;
      host.performance-nvidia= ./modules/host/performance-nvidia.nix;

      # Users
      users.linuxury = ./modules/users/linuxury.nix;
      users.babylinux= ./modules/users/babylinux.nix;
      users.alex     = ./modules/users/alex.nix;

      # Snapper
      snapper = ./modules/snapper.nix;
    };

  in {
    nixosConfigurations = {
      ThinkPad = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit self hyprland niri home-manager;
          jovianModule = jovian.nixosModules.default;
          modules = hostModules;
        };

        modules = [ ./hosts/ThinkPad.nix ];
      };

      Ryzen5900x = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit self hyprland niri home-manager;
          jovianModule = jovian.nixosModules.default;
          modules = hostModules;
        };

        modules = [ ./hosts/Ryzen5900x.nix ];
      };

      Ryzen5800x = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit self hyprland niri home-manager;
          jovianModule = jovian.nixosModules.default;
          modules = hostModules;
        };

        modules = [ ./hosts/Ryzen5800x.nix ];
      };

      ASUSTuff-A15 = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit self hyprland niri home-manager;
          jovianModule = jovian.nixosModules.default;
          modules = hostModules;
        };

        modules = [ ./hosts/ASUSTuff-A15.nix ];
      };

      Alex-Desktop = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit self hyprland niri home-manager;
          jovianModule = jovian.nixosModules.default;
          modules = hostModules;
        };

        modules = [ ./hosts/Alex-Desktop.nix ];
      };

      Alex-Laptop = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit self hyprland niri home-manager;
          jovianModule = jovian.nixosModules.default;
          modules = hostModules;
        };

        modules = [ ./hosts/Alex-Laptop.nix ];
      };

      generic = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit self hyprland niri home-manager;
          jovianModule = jovian.nixosModules.default;
          modules = hostModules;
        };

        modules = [ ./hosts/generic.nix ];
      };
    };
  };
}
