# flake.nix
{
  description = "NixOS Base Configuration with Flakes, ZFS Stripe, LUKS and Impermanence";

  inputs = {
    # Utilizing the unstable channel for maximum performance and modern packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { self, nixpkgs, disko, impermanence, ... }@inputs: {
    nixosConfigurations = {
      # The hostname of your machine is "nixos"
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        # Pass inputs to all modules to access them globally if needed
        specialArgs = { inherit inputs; }; 
        modules = [
          disko.nixosModules.disko
          impermanence.nixosModules.impermanence
          ./disko-config.nix
          ./configuration.nix
        ];
      };
    };
  };
}
