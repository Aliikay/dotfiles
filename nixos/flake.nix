{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
		nixosConfigurations.alikay = nixpkgs.lib.nixosSystem{
			system = "x86_64-linux";
			
			specialArgs = { inherit inputs; };
			modules = [
				./configuration.nix
			];
		};
  };
}
