{
  description = "Alikay's System";

  inputs = {
  	# Default to the June 2024 branch
    nixpkgs.url = "github:nixos/nixpkgs/24.05";
    
    # Latest unstable branch of nixos
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Latest stable branch of nixpkgs, used for version rollback
    # The current latest version is 24.05
    nixpkgs-stable.url = "github:nixos/nixpkgs/24.05";
    
    # Last stable branch of nixpkgs, used for version rollback
    # The current latest version is 23.11
    nixpkgs-last-stable.url = "github:nixos/nixpkgs/23.11";
    
    # Makes various tweaks for audio production
    musnix  = { url = "github:musnix/musnix"; };
    
    # Flatpaks
    nix-flatpak.url = "github:gmodena/nix-flatpak"; # unstable branch. Use github:gmodena/nix-flatpak/?ref=<tag> to pin releases.
    
    # Ags
    ags.url = "github:Aylur/ags";
    
    # Flake version for command-not-found
  	flake-programs-sqlite.url = "github:wamserma/flake-programs-sqlite";
  	flake-programs-sqlite.inputs.nixpkgs.follows = "nixpkgs";
    
    # Hyprland
    #hyprland.url = "github:hyprwm/Hyprland/v0.40.0";
    #hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
		  url = "github:hyprwm/hyprland-plugins";
		  #inputs.hyprland.follows = "hyprland";
		};
    
    # NixOS Conf Manager
    nixos-conf-editor.url = "github:snowfallorg/nixos-conf-editor";
    nix-software-center.url = "github:snowfallorg/nix-software-center";
    
    # pip2nix, autogenerate nix packages based on pip files
    pip2nix.url = "github:nix-community/pip2nix";
    
    # stylix to theme the entire system
    stylix.url = "github:danth/stylix";
    
    # Framework specific tweaks
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    
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

  outputs = inputs@{ self, nixpkgs, nixpkgs-unstable, nixpkgs-stable, nixpkgs-last-stable, home-manager, ...}: 
  let
  	mySpecialArgs = {
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
			   
				pkgs-last-stable = import nixpkgs-last-stable {
				  # Refer to the `system` parameter from
				  # the outer scope recursively
				  inherit inputs;
				  system = "x86_64-linux";
				  config.allowUnfree = true;
				};
			   
			  pkgs-unstable = import nixpkgs-unstable {
			    # Refer to the `system` parameter from
			    # the outer scope recursively
			    inherit inputs;
			    system = "x86_64-linux";
			    config.allowUnfree = true;
			  };
			};
	in
		{#, hyprland, ... }: {			
			nixosConfigurations.alikay = nixpkgs.lib.nixosSystem{
				system = "x86_64-linux";
				specialArgs = mySpecialArgs;
				modules = [
					inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
					inputs.musnix.nixosModules.musnix
					inputs.nix-flatpak.nixosModules.nix-flatpak
					#hyprland.nixosModules.default
					
					./nixos/configuration.nix
					#./nixos/illogical-impulse-dependancies.nix
					./nixos/modules/nix-ld.nix
			  	./nixos/modules/godot.nix
					
					inputs.flake-programs-sqlite.nixosModules.programs-sqlite
					inputs.stylix.nixosModules.stylix
					
					home-manager.nixosModules.home-manager
			    {
			      home-manager.useGlobalPkgs = true;
			      home-manager.useUserPackages = true;
			      home-manager.extraSpecialArgs = mySpecialArgs;
			      home-manager.users.alikay = import ./nixos/home.nix;

			      # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
			    }
				];
			};
  };
}
