{
  description = "A very basic flake";

  inputs = {
  	# Base system
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-23.11"; };
    
    # Makes various tweaks for audio production
    musnix  = { url = "github:musnix/musnix"; };
    
    # Home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
		nixosConfigurations.alikay = nixpkgs.lib.nixosSystem{
			system = "x86_64-linux";
			
			specialArgs = { inherit inputs; };
			modules = [
				inputs.musnix.nixosModules.musnix
				./configuration.nix
				
				home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # TODO replace ryan with your own username
          home-manager.users.alikay = import ./home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
			];
		};
  };
}
