{ config, pkgs, pkgs-stable, inputs, ... }:
{
#let
#  # Godot
#  godot_with_packages = pkgs.godot_4.overrideAttrs (oldAttrs: rec {
#  	buildInputs = oldAttrs.buildInputs ++ [ pkgs.blender ];
#  	#pname = oldAttrs.pname + "-mine";
#  });
#in {
	environment.systemPackages = with pkgs; [
		godot_4
	];
}
