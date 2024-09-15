{ 
	system ? builtins.currentSystem,
	pkgs ? import <nixpkgs> {
		inherit system;
	}
}:

let
	#pythonPkgs = pkgs.callPackage ./python-packages.nix { inherit pkgs; };
  #my-python = pkgs.python311.override { packageOverrides = pythonPkgs; };
in pkgs.mkShell {
  packages = with pkgs; with pkgs.python311Packages; [
  		#my-python
  		#my-python.pkgs.numpy
  		#python311Packages.pygame
  		python311
  		python311Packages.pygobject3
  ];
  
}
