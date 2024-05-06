{ config, pkgs, pkgs-stable, inputs, ... }:
{
	xdg.desktopEntries = {
		rebuild = {
			name = "Rebuild";
			genericName = "System Utility";
			exec = "/home/alikay/dotfiles/scripts/rebuild.sh";
			terminal = true;
			categories = [ "System" "Utility" ];
		};
	};
}
