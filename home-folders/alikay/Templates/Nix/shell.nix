{ 
	system ? builtins.currentSystem,
	pkgs ? import <nixpkgs> {
		inherit system;
	}
}: pkgs.mkShell {
		
	buildInputs = with pkgs; [
	
	];
  
}
