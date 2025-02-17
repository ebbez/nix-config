{
  description = "Ebbez's Nix Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager }: {
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
	modules = [
	  ./hosts/ez-1

#	  home-manager.nixosModules.home-manager
#	  {
#           home-manager.useGlobalPkgs = true;
#	    home-manager.useUserPackages = true;
#	    home-manager.users.ebbe = import ./home;
#	  }
	];
      };

      "ez-2" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ 
	  ./hosts/ez-2

#	  home-manager.nixosModules.home-manager
#         {
#	    home-manager.useGlobalPkgs = true;
#	    home-manager.useUserPackages = true;
#           home-manager.users.ebbe = import ./home;
#	  }
	];
      };

    };
  };
}
