{ config, pkgs, pkgs-stable, pkgs-unstable, inputs, ... }:
{
#let
#  # Godot
#  godot_with_packages = pkgs.godot_4.overrideAttrs (oldAttrs: rec {
#  	buildInputs = oldAttrs.buildInputs ++ [ pkgs.blender ];
#  	#pname = oldAttrs.pname + "-mine";
#  });
#in {
	environment.systemPackages = with pkgs; [
		scons #building
		godot_4 #editor
	];
}
