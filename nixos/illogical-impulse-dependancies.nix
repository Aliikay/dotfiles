# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  programs.npm.enable = true;
  
  environment.systemPackages = with pkgs; [
  	# Basic
		coreutils
		cliphist
		cmake
		curl
		fuzzel
		rsync
		wget
		ripgrep
		gojq
		meson
		typescript
		gjs
		dart-sass
		axel
		
		# Python
		#python-build
		#python-materialyoucolor-git
		#python-pillow
		#python-pywal
		#python-setuptools-scm
		#python-wheel
		
		# Audio
		pavucontrol
		libdbusmenu-gtk3
		plasma-browser-integration
		playerctl
		swww
		
		# GTK
		webp-pixbuf-loader
		gtk-layer-shell
		gtk3
		gtksourceview3
		gobject-introspection
		upower
		yad
		ydotool
		
		# Gnome
		blueberry
		brightnessctl
		wlsunset
		
		# Widgets
		#python-pywayland
		#python-psutil
		wlogout
		wl-clipboard
		
		# Fonts & Themes
		qt5ct
		gradience
		fontconfig
		fish
		foot
		starship
		nerdfonts
  ];
  
  fonts.packages = with pkgs; [
	jetbrains-mono
	material-symbols
  ];

}
