{ config, pkgs, pkgs-stable, inputs, ... }:
{
	xdg.desktopEntries = {
		rebuild = {
			name = "Rebuild";
			genericName = "System Utility";
			exec = "/home/alikay/dotfiles/scripts/rebuild.sh";
			terminal = true;
			icon = "/home/alikay/dotfiles/icons/nixos-rebuild.png";
			categories = [ "System" "Utility" ];
		};
		
		splittunnel = {
			name = "Split Tunnel Apps";
			genericName = "System Utility";
			exec = "/home/alikay/dotfiles/scripts/run-apps-with-split-tunnel.sh";
			terminal = false;
			icon = "/home/alikay/dotfiles/icons/run-apps-split-tunnel.png";
			categories = [ "System" "Utility" ];
		};
		
		convert-videos-to-webm = {
			name = "Convert To Webm";
			genericName = "System Utility";
			exec = "python /home/alikay/dotfiles/scripts/convert-videos-to-webm.py";
			terminal = true;
			categories = [ "System" "Utility" ];
		};
	};
}
