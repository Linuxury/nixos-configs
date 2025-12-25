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
    in {
      # Define reusable module paths for host modules
      modules = {
        display.gdm     = ./modules/display/gdm.nix;
        desktop.common  = ./modules/desktop/common.nix;
        desktop.cosmic  = ./modules/desktop/cosmic.nix;
        # Add KDE, GNOME, Hyprland, Niri later if desired
      };

      nixosConfigurations = {
        ThinkPad = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; };
          modules = [ ./hosts/ThinkPad.nix ];
        };

        Ryzen5900x = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; };
          modules = [ ./hosts/Ryzen5900x.nix ];
        };

        Ryzen5800x = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; };
          modules = [ ./hosts/Ryzen5800x.nix ];
        };

        ASUSTuff-A15 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; };
          modules = [ ./hosts/ASUSTuff-A15.nix ];
        };

        Alex-Desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; };
          modules = [ ./hosts/Alex-Desktop.nix ];
        };

        Alex-Laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; };
          modules = [ ./hosts/Alex-Laptop.nix ];
        };

        generic = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager; };
          modules = [ ./hosts/generic.nix ];
        };
      };
    };
}
