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
    
    # Copied from PacificViking's config
    pkgs.nerdfonts
    pkgs.nodejs
    pkgs.ghc
    pkgs.wofi
    pkgs.wl-clipboard
    pkgs.wl-clipboard-x11
    pkgs.wl-clip-persist
    pkgs.udisks
    pkgs.udisks2
    pkgs.udiskie
    pkgs.inxi
    pkgs.powertop
    pkgs.yt-dlp
    
    pkgs.ffmpeg
    pkgs.grim
    pkgs.slurp
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast
    pkgs.hyprpicker
    pkgs.findutils
    pkgs.ripgrep
    pkgs.killall
    pkgs.bat
    pkgs.curl.dev
    pkgs.dfeet
    pkgs.d-spy
    pkgs.pqiv

    pkgs.nodejs_21

    #pkgs.gnome.nautilus
    pkgs.xfce.xfce4-icon-theme
    #pkgs.xfce.thunar-volman
    #pkgs.xfce.tumbler
    #pkgs.gvfs
    pkgs.polkit_gnome
    pkgs.xdg-utils
    pkgs.easyeffects

    pkgs.egl-wayland
    #pkgs.opentabletdriver
    #pkgs.wacomtablet
    #pkgs.xf86_input_wacom
    #pkgs.libwacom
    pkgs.font-awesome

    pkgs.xorg.setxkbmap
    pkgs.xkb-switch
    pkgs.xkblayout-state
    pkgs.perl538Packages.FileMimeInfo
    pkgs.xorg.xdpyinfo

    pkgs.mpd
    pkgs.mpdevil
    pkgs.ncmpcpp
    pkgs.mpc-cli
    pkgs.pms
    pkgs.hydrogen  # drum synthesizer
    #pkgs.vcv-rack
    pkgs.freepats
    pkgs.ChowKick
    pkgs.drumkv1
    pkgs.drumgizmo
    pkgs.bitwig-studio

    (pkgs.fenix.latest.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])

    pkgs.gnome.dconf-editor
    pkgs.nvtop-nvidia

    pkgs.qt5.full
    pkgs.libsForQt5.qt5ct
    pkgs.libsForQt5.qt5.qtwayland
    pkgs.libsForQt5.plasma-wayland-protocols
    #pkgs.libsForQt5.dolphin
    pkgs.libsForQt5.kwayland
    pkgs.libsForQt5.kwayland-integration
    #pkgs.libsForQt5.qtstyleplugin-kvantum
    (pkgs.catppuccin-kvantum.override {accent = "Yellow"; variant = "Mocha";})
    pkgs.libsForQt5.breeze-icons
  ];
  
  fonts.packages = with pkgs; [
		jetbrains-mono
		material-symbols
  ];

}
