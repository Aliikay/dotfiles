{
  description = "A very basic flake";

  inputs = {
  	# Default to the nixos-unstable branch
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Latest stable branch of nixpkgs, used for version rollback
    # The current latest version is 23.11
    nixpkgs-stable.url = "github:nixos/nixpkgs/23.11";
    
    # Makes various tweaks for audio production
    musnix  = { url = "github:musnix/musnix"; };
    
    # Flatpaks
    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.
    
    # Ags
    ags.url = "github:Aylur/ags";
    
    # Hyprland
    #hyprland.url = "github:hyprwm/Hyprland";
    
    # Home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      #url = "github:nix-community/home-manager/release-23.11";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nixpkgs-stable, home-manager, nix-flatpak, ... }: {
		nixosConfigurations.alikay = nixpkgs.lib.nixosSystem{
			system = "x86_64-linux";
			
			specialArgs = {
					inherit inputs;
          # To use packages from nixpkgs-unstable,
          # we configure some parameters for it first
          pkgs-stable = import nixpkgs-stable {
            # Refer to the `system` parameter from
            # the outer scope recursively
            inherit inputs;
            system = "x86_64-linux";
            config.allowUnfree = true;
           };
			};
			modules = [
				inputs.musnix.nixosModules.musnix
				nix-flatpak.nixosModules.nix-flatpak
				
				./configuration.nix
				./illogical-impulse-dependancies.nix
				
				home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          home-manager.extraSpecialArgs = {inherit inputs; };

          home-manager.users.alikay = import ./home.nix;

          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
			];
		};
  };
}
