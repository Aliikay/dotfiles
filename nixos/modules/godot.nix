{ pkgs, self, ... }:
{
  # Godot
  #pkgs.godot_4.package = pkgs.godot_4.overrideAttrs (oldAttrs: rec {
  	#buildInputs = oldAttrs ++ [pkgs.blender];
  #});
  #pkgs.godot_4.enable = true;
  #godot_with_packages = pkgs.godot_4.overrideAttrs (oldAttrs: rec {
  #	pname = oldAttrs.pname + "-mine";
  #});
  let
		helloBar = pkgs.hello.overrideAttrs(finalAttrs: previousAttrs: {
			pname = previousAttrs.pname + "-bar";
		});
	in
	{
		home.packages with pkgs; [
			helloBar
		]
	}
}
