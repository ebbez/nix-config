{
  description = "Ebbe's NixOS Flake";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager,
    ...
    } @ inputs: {
    
    nixosConfigurations.ez-1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/ez-1/configuration.nix
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.ebbe = import ./home/default.nix;
	}
      ];
    };

    nixosConfigurations.ez-2 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	./machines/ez-2/configuration.nix
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.ebbe = import ./home/default.nix;
	}
      ];
    };

  };
}
