{
  description = "Ebbe's NixOS Flake";

  inputs = {

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { 
    self, 
    nixpkgs, 
    home-manager,
    plasma-manager,
    lanzaboote,
    ...
    } @ inputs: {
    
    nixosConfigurations.ez-1 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./machines/ez-1
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
	  home-manager.users.ebbe = import ./home;
	}
      ];
    };

    nixosConfigurations.ez-2 = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
	./machines/ez-2
	lanzaboote.nixosModules.lanzaboote
	home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.sharedModules = [ plasma-manager.homeManagerModules.plasma-manager ];
	  home-manager.users.ebbe = import ./home;
	}
      ];
    };

  };
}
