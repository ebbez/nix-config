{
  description = "Ebbez's Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    lanzaboote.url = "github:nix-community/lanzaboote/v0.4.2";
    lanzaboote.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, lanzaboote }@attrs: {
    nixpkgs.config.allowUnfree = true;

    homeConfigurations = {
      "ebbe" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; config = { allowUnfree = true; }; };
        modules = [ ./home ];
      };
    };

    nixosConfigurations = {
      
      "ez-1" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./hosts/ez-1.nix
          ./modules/pc-common.nix
          ./modules/nl-locale.nix
          #./modules/secureboot.nix
          #./modules/tpm-unlock.nix
        ];
      };

      "ez-2" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [ 
          ./hosts/ez-2.nix
          ./modules/pc-common.nix
          ./modules/nl-locale.nix
          ./modules/secureboot.nix
          ./modules/tpm-unlock.nix
        ];
      };

    };
  };
}
