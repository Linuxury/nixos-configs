{
  description = "My multi-host NixOS flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations = {
        ThinkPad = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hardware-configuration.nix
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };

        Ryzen5900x = nixpkgs.lib.nixosSystem { inherit system; modules = [ ]; };
        Ryzen5800x = nixpkgs.lib.nixosSystem { inherit system; modules = [ ]; };
        ASUSTuff-A15 = nixpkgs.lib.nixosSystem { inherit system; modules = [ ]; };
        Alex-Desktop = nixpkgs.lib.nixosSystem { inherit system; modules = [ ]; };
        Alex-Laptop = nixpkgs.lib.nixosSystem { inherit system; modules = [ ]; };
      };
    };
}
