# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  
  programs.npm.enable = true;
  
  environment.systemPackages = with pkgs; with nodePackages_latest; with gnome; with libsForQt5;[
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
		
		# COPIED FROM end4's flake
		# gui
    blueberry
    (mpv.override { scripts = [ mpvScripts.mpris ]; })
    d-spy
    dolphin
    figma-linux
    kolourpaint
    github-desktop
    gnome.nautilus
    icon-library
    dconf-editor
    qt5.qtimageformats
    vlc
    yad

    # tools
    bat
    eza
    fd
    ripgrep
    fzf
    socat
    jq
    gojq
    acpi
    ffmpeg
    libnotify
    killall
    zip
    unzip
    glib
    foot
    kitty
    starship
    showmethekey
    vscode
    ydotool

    # theming tools
    gradience
    gnome-tweaks

    # hyprland
    brightnessctl
    cliphist
    fuzzel
    grim
    hyprpicker
    tesseract
    imagemagick
    pavucontrol
    playerctl
    swappy
    swaylock-effects
    swayidle
    slurp
    swww
    wayshot
    wlsunset
    wl-clipboard
    wf-recorder

    # langs
    nodejs
    gjs
    bun
    cargo
    go
    gcc
    typescript
    eslint
  ];
  
  fonts.packages = with pkgs; [
		jetbrains-mono
		material-symbols
  ];

}
