{
  description = "Ebbez's Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Userspace management
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Automatic EFI signing and boot managing
    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, lanzaboote }@attrs: {

    nixosConfigurations = {
      
      "ez-1" = nixpkgs.lib.nixosSystem {
        pkgs = import nixpkgs { 
          system = "x86_64-linux"; 
          config.allowUnfree = true; 
        };
        specialArgs = attrs;
        modules = [
          ./hosts/ez-1.nix
          ./modules/pc-common.nix
          ./modules/nl-locale.nix
          ./modules/secureboot.nix
          ./modules/tpm-unlock.nix
          ./modules/gaming.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ebbe = import ./home.nix;
          }
        ];
      };

      "ez-2" = nixpkgs.lib.nixosSystem {
        pkgs = import nixpkgs { 
          system = "x86_64-linux"; 
          config.allowUnfree = true; 
        };
        specialArgs = attrs;
        modules = [ 
          ./hosts/ez-2.nix
          ./modules/pc-common.nix
          ./modules/nl-locale.nix
          ./modules/secureboot.nix
          ./modules/tpm-unlock.nix
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ebbe = import ./home.nix;
          }
        ];
      };

    };
  };
}
