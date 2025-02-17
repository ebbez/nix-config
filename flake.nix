{
  description = "Ebbez's Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: {
    nixosConfigurations = {
      "ez-2" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
	  ./hosts/ez-2/configuration.nix 
	  home-manager.nixosModules.home-manager
          {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
            home-manager.users.ebbe = import ./user/home.nix;
	  }
	];
      };
    };
  };
}
