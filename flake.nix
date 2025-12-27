{
  description = "My modular multi-host NixOS flake";

  #########################
  # Inputs
  #########################
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

      #########################
      # Host-specific module paths
      #########################
      hostModules = {
        #########################
        # Hardware configuration
        #########################
        hardware-configuration.default = ./modules/hardware-configuration/default.nix;
        #########################
        # Display managers
        #########################
        display.gdm = ./modules/display/gdm.nix;
        display.cosmicGreeter = ./modules/display/cosmic-greeter.nix;
        display.lightdm = ./modules/display/lightdm.nix;
        display.sddm = ./modules/display/sddm.nix;
        #########################
        # Desktop environments
        #########################
        desktop.default = ./modules/desktop/default.nix;
        desktop.cosmic = ./modules/desktop/cosmic.nix;
        desktop.gnome = ./modules/desktop/gnome.nix;
        desktop.kde = ./modules/desktop/kde.nix;
        desktop.hyprland = ./modules/desktop/hyprland.nix;
        desktop.niri = ./modules/desktop/niri.nix;
        #########################
        # Host-specific modules
        #########################
        host.laptop = ./modules/host/laptop.nix;
        host.gaming = ./modules/host/gaming.nix;
        host.coding = ./modules/host/coding.nix;
        host.performance-cpu = ./modules/host/performance-cpu.nix;
        host.performance-amd = ./modules/host/performance-amd.nix;
        host.performance-nvidia = ./modules/host/performance-nvidia.nix;
        #########################
        # Users
        #########################
        users.linuxury = ./modules/users/linuxury.nix;
        users.babylinux = ./modules/users/babylinux.nix;
        users.alex = ./modules/users/alex.nix;
        #########################
        # Snapper
        #########################
        snapper = ./modules/snapper.nix;
      };

      #########################
      # Common modules applied to ALL hosts
      #########################
      commonModules = [
        # Home Manager integration
        home-manager.nixosModules.home-manager

        #########################
        # Clean & quiet boot with Plymouth splash + watchdog fixes
        #########################
        {
          boot = {
            plymouth = {
              enable = true;
              theme = "breeze";  # NixOS automatically provides a branded Breeze theme – no extra packages needed!
            };

            consoleLogLevel = 0;
            initrd.verbose = false;

            kernelParams = [
              "quiet"
              "splash"
              "loglevel=3"
              "rd.systemd.show_status=auto"
              "rd.udev.log_priority=3"
              "udev.log_priority=3"
              "vt.global_cursor_default=0"
              "nowatchdog"
            ];
          };

          # New way to configure systemd manager settings (watchdog + timeouts)
          systemd.settings.Manager = {
            # Disable watchdogs to prevent "watchdog did not stop!" message
            RuntimeWatchdogSec = "0";
            RebootWatchdogSec = "0";
            KExecWatchdogSec = "0";

            # Speed up shutdown by reducing default service stop timeout
            DefaultTimeoutStopSec = "10s";
          };

          # Prevent NetworkManager from delaying shutdown/reboot
          systemd.services.NetworkManager-wait-online.enable = false;
        }
      ];

    in {

      #########################
      # NixOS Configurations (all hosts)
      #########################
      nixosConfigurations = {
        ThinkPad = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager hostModules; };
          modules = commonModules ++ [ ./hosts/ThinkPad.nix ];
        };

        Ryzen5900x = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager hostModules; };
          modules = commonModules ++ [ ./hosts/Ryzen5900x.nix ];
        };

        Ryzen5800x = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager hostModules; };
          modules = commonModules ++ [ ./hosts/Ryzen5800x.nix ];
        };

        ASUSTuff-A15 = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager hostModules; };
          modules = commonModules ++ [ ./hosts/ASUSTuff-A15.nix ];
        };

        Alex-Desktop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager hostModules; };
          modules = commonModules ++ [ ./hosts/Alex-Desktop.nix ];
        };

        Alex-Laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager hostModules; };
          modules = commonModules ++ [ ./hosts/Alex-Laptop.nix ];
        };

        generic = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit self hyprland niri home-manager hostModules; };
          modules = commonModules ++ [ ./hosts/generic.nix ];
        };
      };
    };
}
