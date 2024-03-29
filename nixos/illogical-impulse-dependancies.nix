# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
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
		npm
		meson
		typescript
		gjs
		dart-sass
		axel
		
		# Python
		python-build
		python-materialyoucolor-git
		python-pillow
		python-pywal
		python-setuptools-scm
		python-wheel
		
		# Basic Graphical Env
		xorg-xrandr
		
		# Audio
		pavucontrol
		wireplumber
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
		polkit-gnome
		gnome-keyring
		gnome-control-center
		blueberry
		networkmanager
		brightnessctl
		wlsunset
		gnome-bluetooth-3.0
		
		# Widgets
		python-pywayland
		python-psutil
		wlogout
		wl-clipboard
		
		# Fonts & Themes
		adw-gtk3-git
		qt5ct
		qt5-wayland
		gradience-git
		fontconfig
		ttf-readex-pro
		ttf-jetbrains-mono-nerd
		ttf-material-symbols-variable-git
		ttf-space-mono-nerd
		fish
		foot
		starship
  ];

}
