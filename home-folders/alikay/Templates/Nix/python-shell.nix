{ 
	system ? builtins.currentSystem,
	pkgs ? import <nixpkgs> {
		inherit system;
	}
}: pkgs.mkShell {
	venvDir = "./.venv";
		
	buildInputs = with pkgs; [
		python311
		python3Packages.venvShellHook
	];
	
	packages = with pkgs; with pkgs.python311Packages; [
			python311
	];
	
	postVenvCreation = ''
	  pip install -r ${./requirements.txt}
	'';
	
	shellHook = ''
	  venvShellHook
	'';
  
}
